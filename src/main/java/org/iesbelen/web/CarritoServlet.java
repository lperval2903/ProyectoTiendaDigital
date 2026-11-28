package org.iesbelen.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.dao.CheckoutService;
import org.iesbelen.dao.DaoException;
import org.iesbelen.dao.PedidosDAO;
import org.iesbelen.dao.PedidosDAOImpl;
import org.iesbelen.dao.ProductoDAO;
import org.iesbelen.dao.ProductoDAOImpl;
import org.iesbelen.model.CartItem;
import org.iesbelen.model.Pedidos;
import org.iesbelen.model.Producto;
import org.iesbelen.model.Usuario;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@WebServlet("/carrito/*")
public class CarritoServlet extends HttpServlet {

    private static final String CART_SESSION_KEY = "carrito";

    private final ProductoDAO productoDAO = new ProductoDAOImpl();
    private final PedidosDAO pedidosDAO = new PedidosDAOImpl();
    private final CheckoutService checkoutService = new CheckoutService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        try {
            if (path == null || "/".equals(path)) {
                showCart(request, response);
            } else if ("/confirmado".equals(path)) {
                showConfirmation(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (DaoException e) {
            fail(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        try {
            if ("/agregar".equals(path)) {
                addItem(request, response);
            } else if ("/actualizar".equals(path)) {
                updateItem(request, response);
            } else if ("/eliminar".equals(path)) {
                removeItem(request, response);
            } else if ("/finalizar".equals(path)) {
                checkout(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (IllegalArgumentException e) {
            flash(request.getSession(), e.getMessage());
            response.sendRedirect(request.getContextPath() + "/carrito");
        } catch (DaoException e) {
            fail(request, response, e);
        }
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<Integer, CartItem> cart = getCart(request.getSession());
        List<CartItem> items = new ArrayList<CartItem>(cart.values());
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(BigDecimal.valueOf(item.getSubtotal()));
        }
        request.setAttribute("itemsCarrito", items);
        request.setAttribute("totalCarrito", total.setScale(2, java.math.RoundingMode.HALF_UP).doubleValue());
        request.setAttribute("mensajeCarrito", request.getSession().getAttribute("mensajeCarrito"));
        request.getSession().removeAttribute("mensajeCarrito");
        request.getRequestDispatcher("/WEB-INF/carrito.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = positiveInt(request.getParameter("idProducto"), "Producto");
        int quantity = positiveInt(request.getParameter("cantidad"), "Cantidad");
        Producto product = findProduct(productId);
        Map<Integer, CartItem> cart = getCart(request.getSession());
        CartItem existing = cart.get(productId);
        int existingQuantity = existing == null ? 0 : existing.getCantidad();
        if (quantity > product.getStock() - existingQuantity) {
            throw new IllegalArgumentException("No hay stock suficiente para " + product.getNombreProducto() + ".");
        }
        int newQuantity = quantity + existingQuantity;
        cart.put(productId, new CartItem(product, newQuantity));
        response.sendRedirect(request.getContextPath() + "/carrito");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = positiveInt(request.getParameter("idProducto"), "Producto");
        int quantity = positiveInt(request.getParameter("cantidad"), "Cantidad");
        Producto product = findProduct(productId);
        if (quantity > product.getStock()) {
            throw new IllegalArgumentException("La cantidad supera el stock disponible.");
        }
        getCart(request.getSession()).put(productId, new CartItem(product, quantity));
        response.sendRedirect(request.getContextPath() + "/carrito");
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = positiveInt(request.getParameter("idProducto"), "Producto");
        getCart(request.getSession()).remove(productId);
        response.sendRedirect(request.getContextPath() + "/carrito");
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario-logado");
        if (user == null) {
            session.setAttribute("rutaTrasLogin", "/carrito");
            response.sendRedirect(request.getContextPath() + "/usuarios/login");
            return;
        }

        Map<Integer, CartItem> cart = getCart(session);
        List<CartItem> items = new ArrayList<CartItem>(cart.values());
        int orderId = checkoutService.checkout(user.getIdUsuario(), items);
        cart.clear();
        response.sendRedirect(request.getContextPath() + "/carrito/confirmado?idPedido=" + orderId);
    }

    private void showConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario user = session == null ? null : (Usuario) session.getAttribute("usuario-logado");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/usuarios/login");
            return;
        }
        int orderId = positiveInt(request.getParameter("idPedido"), "Pedido");
        Optional<Pedidos> order = pedidosDAO.find(orderId);
        if (!order.isPresent() || order.get().getIdUsuario() != user.getIdUsuario()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("pedido", order.get());
        request.getRequestDispatcher("/WEB-INF/pedido-confirmado.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCart(HttpSession session) {
        Object value = session.getAttribute(CART_SESSION_KEY);
        if (value == null) {
            Map<Integer, CartItem> cart = new LinkedHashMap<Integer, CartItem>();
            session.setAttribute(CART_SESSION_KEY, cart);
            return cart;
        }
        if (!(value instanceof Map)) {
            throw new IllegalStateException("El carrito de la sesión no tiene un formato válido.");
        }
        Map<?, ?> stored = (Map<?, ?>) value;
        for (Map.Entry<?, ?> entry : stored.entrySet()) {
            if (!(entry.getKey() instanceof Integer) || !(entry.getValue() instanceof CartItem)) {
                throw new IllegalStateException("El carrito de la sesión contiene datos no válidos.");
            }
        }
        return (Map<Integer, CartItem>) stored;
    }

    private Producto findProduct(int id) {
        Optional<Producto> product = productoDAO.find(id);
        if (!product.isPresent()) {
            throw new IllegalArgumentException("El producto seleccionado no está disponible.");
        }
        if (product.get().getStock() < 1) {
            throw new IllegalArgumentException("El producto seleccionado está agotado.");
        }
        return product.get();
    }

    private int positiveInt(String value, String label) {
        try {
            int parsed = Integer.parseInt(value);
            if (parsed > 0) {
                return parsed;
            }
        } catch (NumberFormatException ignored) {
            // Report the same validation message for missing, malformed, and non-positive values.
        }
        throw new IllegalArgumentException(label + " debe ser un entero mayor que cero.");
    }

    private void flash(HttpSession session, String message) {
        session.setAttribute("mensajeCarrito", message);
    }

    private void fail(HttpServletRequest request, HttpServletResponse response, DaoException exception)
            throws IOException {
        getServletContext().log("Error al procesar el carrito.", exception);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "No se pudo completar la operación. Revisa la conexión a la base de datos.");
    }
}
