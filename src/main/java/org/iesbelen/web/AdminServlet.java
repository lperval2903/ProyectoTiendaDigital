package org.iesbelen.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.iesbelen.dao.CategoriasDAO;
import org.iesbelen.dao.CategoriasDAOImpl;
import org.iesbelen.dao.DaoException;
import org.iesbelen.dao.DetallePedidoDAO;
import org.iesbelen.dao.DetallePedidoDAOImpl;
import org.iesbelen.dao.PedidosDAO;
import org.iesbelen.dao.PedidosDAOImpl;
import org.iesbelen.dao.ProductoDAO;
import org.iesbelen.dao.ProductoDAOImpl;
import org.iesbelen.dao.UsuarioDAO;
import org.iesbelen.dao.UsuarioDAOImpl;
import org.iesbelen.model.Categorias;
import org.iesbelen.model.DetallePedido;
import org.iesbelen.model.Pedidos;
import org.iesbelen.model.Producto;
import org.iesbelen.model.Usuario;
import org.iesbelen.util.PasswordUtil;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final CategoriasDAO categoriasDAO = new CategoriasDAOImpl();
    private final ProductoDAO productoDAO = new ProductoDAOImpl();
    private final UsuarioDAO usuarioDAO = new UsuarioDAOImpl();
    private final PedidosDAO pedidosDAO = new PedidosDAOImpl();
    private final DetallePedidoDAO detalleDAO = new DetallePedidoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = normalize(request.getPathInfo());
        if ("/".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/admin/categorias");
            return;
        }
        try {
            if ("/categorias".equals(path)) {
                request.setAttribute("listaCategorias", categoriasDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/categorias/categorias.jsp");
            } else if ("/productos".equals(path)) {
                request.setAttribute("listaProductos", productoDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/producto/producto.jsp");
            } else if ("/productos/crear".equals(path)) {
                request.setAttribute("listaCategorias", categoriasDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/producto/crear-producto.jsp");
            } else if ("/usuarios".equals(path)) {
                request.setAttribute("listaUsuarios", usuarioDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/usuario/usuario.jsp");
            } else if ("/pedidos".equals(path)) {
                request.setAttribute("listaPedidos", pedidosDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/pedidos/pedidos.jsp");
            } else if ("/detallePedido".equals(path)) {
                request.setAttribute("listaDetallesPedido", detalleDAO.getAll());
                forward(request, response, "/WEB-INF/elementos/detallePedido/detallePedido.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (DaoException e) {
            fail(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");
        String[] parts = normalize(request.getPathInfo()).split("/");
        if (parts.length != 3) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String resource = parts[1];
        String action = parts[2];
        try {
            if ("categorias".equals(resource)) {
                handleCategoria(request, resource, action);
            } else if ("productos".equals(resource)) {
                handleProducto(request, resource, action);
            } else if ("usuarios".equals(resource)) {
                handleUsuario(request, resource, action);
            } else if ("pedidos".equals(resource)) {
                handlePedido(request, resource, action);
            } else if ("detallePedido".equals(resource)) {
                handleDetalle(request, resource, action);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/admin/" + resource);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (DaoException e) {
            fail(request, response, e);
        }
    }

    private void handleCategoria(HttpServletRequest request, String resource, String action) {
        if ("crear".equals(action)) {
            Categorias categoria = new Categorias();
            categoria.setNombreCategoria(required(request, "nombreCategoria", 100));
            categoriasDAO.create(categoria);
        } else if ("editar".equals(action)) {
            Categorias categoria = new Categorias();
            categoria.setIdCategoria(positiveInt(request, "idCategoria"));
            categoria.setNombreCategoria(required(request, "nombreCategoria", 100));
            categoriasDAO.update(categoria);
        } else if ("borrar".equals(action)) {
            categoriasDAO.delete(positiveInt(request, "idCategoria"));
        } else {
            throw new IllegalArgumentException("Acción de categoría no válida.");
        }
    }

    private void handleProducto(HttpServletRequest request, String resource, String action) {
        if ("crear".equals(action)) {
            Producto producto = readProducto(request);
            productoDAO.create(producto);
        } else if ("editar".equals(action)) {
            Producto producto = readProducto(request);
            producto.setIdProducto(positiveInt(request, "idProducto"));
            productoDAO.update(producto);
        } else if ("borrar".equals(action)) {
            productoDAO.delete(positiveInt(request, "idProducto"));
        } else {
            throw new IllegalArgumentException("Acción de producto no válida.");
        }
    }

    private Producto readProducto(HttpServletRequest request) {
        Producto producto = new Producto();
        producto.setIdCategoria(positiveInt(request, "idCategoria"));
        producto.setNombreProducto(required(request, "nombreProducto", 150));
        producto.setStock(nonNegativeInt(request, "stock"));
        producto.setPrecio(nonNegativeDouble(request, "precio"));
        return producto;
    }

    private void handleUsuario(HttpServletRequest request, String resource, String action) {
        if ("crear".equals(action)) {
            String password = required(request, "contrasena");
            Usuario usuario = new Usuario();
            usuario.setNombre(required(request, "nombre", 50));
            usuario.setContrasena(PasswordUtil.hash(password));
            usuario.setRol(validRole(request.getParameter("rol")));
            usuarioDAO.create(usuario);
        } else if ("editar".equals(action)) {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(positiveInt(request, "idUsuario"));
            usuario.setNombre(required(request, "nombre", 50));
            usuario.setRol(validRole(request.getParameter("rol")));
            ensureAdminRemains(usuario.getIdUsuario(), usuario.getRol());
            usuarioDAO.update(usuario);
        } else if ("borrar".equals(action)) {
            int id = positiveInt(request, "idUsuario");
            Usuario current = (Usuario) request.getSession(false).getAttribute("usuario-logado");
            if (id == current.getIdUsuario()) {
                throw new IllegalArgumentException("No puedes eliminar la cuenta con la que has iniciado sesión.");
            }
            ensureAdminRemains(id, null);
            usuarioDAO.delete(id);
        } else {
            throw new IllegalArgumentException("Acción de usuario no válida.");
        }
    }

    private void ensureAdminRemains(int changedId, String newRole) {
        List<Usuario> users = usuarioDAO.getAll();
        long remainingAdmins = users.stream()
                .filter(user -> "admin".equals(user.getRol()))
                .filter(user -> user.getIdUsuario() != changedId || "admin".equals(newRole))
                .count();
        if (remainingAdmins == 0) {
            throw new IllegalArgumentException("Debe quedar al menos un administrador activo.");
        }
    }

    private void handlePedido(HttpServletRequest request, String resource, String action) {
        if ("crear".equals(action)) {
            Pedidos pedido = new Pedidos();
            pedido.setIdUsuario(positiveInt(request, "idUsuario"));
            pedido.setFecha(LocalDateTime.parse(required(request, "fecha")));
            pedido.setEstado(validOrderState(request.getParameter("estado")));
            pedido.setTotal(0);
            pedidosDAO.create(pedido);
        } else if ("editar".equals(action)) {
            Pedidos pedido = new Pedidos();
            pedido.setIdPedido(positiveInt(request, "idPedido"));
            pedido.setEstado(validOrderState(request.getParameter("estado")));
            pedidosDAO.update(pedido);
        } else if ("borrar".equals(action)) {
            pedidosDAO.delete(positiveInt(request, "idPedido"));
        } else {
            throw new IllegalArgumentException("Acción de pedido no válida.");
        }
    }

    private void handleDetalle(HttpServletRequest request, String resource, String action) {
        if ("crear".equals(action)) {
            detalleDAO.create(readDetalle(request));
        } else if ("editar".equals(action)) {
            DetallePedido detalle = readDetalle(request);
            detalle.setIdDetalle(positiveInt(request, "idDetalle"));
            detalleDAO.update(detalle);
        } else if ("borrar".equals(action)) {
            detalleDAO.delete(positiveInt(request, "idDetalle"));
        } else {
            throw new IllegalArgumentException("Acción de detalle no válida.");
        }
    }

    private DetallePedido readDetalle(HttpServletRequest request) {
        DetallePedido detalle = new DetallePedido();
        detalle.setIdProducto(positiveInt(request, "idProducto"));
        detalle.setIdPedido(positiveInt(request, "idPedido"));
        detalle.setCantidad(positiveInt(request, "cantidad"));
        detalle.setPrecioUd(nonNegativeDouble(request, "precioUd"));
        return detalle;
    }

    private int positiveInt(HttpServletRequest request, String name) {
        int value = parseInt(required(request, name), name);
        if (value <= 0) {
            throw new IllegalArgumentException(name + " debe ser mayor que cero.");
        }
        return value;
    }

    private int nonNegativeInt(HttpServletRequest request, String name) {
        int value = parseInt(required(request, name), name);
        if (value < 0) {
            throw new IllegalArgumentException(name + " no puede ser negativo.");
        }
        return value;
    }

    private int parseInt(String value, String name) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(name + " debe ser un número entero.");
        }
    }

    private double nonNegativeDouble(HttpServletRequest request, String name) {
        try {
            double value = Double.parseDouble(required(request, name));
            if (!Double.isFinite(value) || value < 0) {
                throw new IllegalArgumentException(name + " debe ser un número positivo válido.");
            }
            return value;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(name + " debe ser un número válido.");
        }
    }

    private String required(HttpServletRequest request, String name) {
        return required(request, name, Integer.MAX_VALUE);
    }

    private String required(HttpServletRequest request, String name, int maximumLength) {
        String value = request.getParameter(name);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException("Falta el campo " + name + ".");
        }
        String trimmed = value.trim();
        if (trimmed.length() > maximumLength) {
            throw new IllegalArgumentException(name + " supera la longitud máxima permitida.");
        }
        return trimmed;
    }

    private String validRole(String role) {
        if (!Arrays.asList("admin", "usuario").contains(role)) {
            throw new IllegalArgumentException("El rol indicado no es válido.");
        }
        return role;
    }

    private String validOrderState(String state) {
        if (!Arrays.asList("pendiente", "enviado", "entregado").contains(state)) {
            throw new IllegalArgumentException("El estado indicado no es válido.");
        }
        return state;
    }

    private String normalize(String pathInfo) {
        return pathInfo == null || pathInfo.isEmpty() ? "/" : pathInfo.replaceAll("/+$", "");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        request.getRequestDispatcher(path).forward(request, response);
    }

    private void fail(HttpServletRequest request, HttpServletResponse response, DaoException exception)
            throws IOException {
        getServletContext().log("Error al procesar " + request.getRequestURI(), exception);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "No se pudo completar la operación. Revisa la conexión y el esquema de base de datos.");
    }
}
