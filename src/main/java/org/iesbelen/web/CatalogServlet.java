package org.iesbelen.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.iesbelen.dao.CategoriasDAOImpl;
import org.iesbelen.dao.DaoException;
import org.iesbelen.dao.ProductoDAOImpl;
import org.iesbelen.model.Producto;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/tienda")
public class CatalogServlet extends HttpServlet {

    private final CategoriasDAOImpl categoriasDAO = new CategoriasDAOImpl();
    private final ProductoDAOImpl productoDAO = new ProductoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Producto> productos = productoDAO.getAll();
            String categoryId = request.getParameter("categoria");
            String search = request.getParameter("buscar");

            if (categoryId != null && !categoryId.trim().isEmpty()) {
                try {
                    final int id = Integer.parseInt(categoryId);
                    productos = productos.stream()
                            .filter(producto -> producto.getIdCategoria() == id)
                            .collect(Collectors.toList());
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "La categoría no es válida.");
                    return;
                }
            }
            if (search != null && !search.trim().isEmpty()) {
                final String term = search.trim().toLowerCase(Locale.ROOT);
                productos = productos.stream()
                        .filter(producto -> producto.getNombreProducto().toLowerCase(Locale.ROOT).contains(term))
                        .collect(Collectors.toList());
            }

            request.setAttribute("listaCategorias", categoriasDAO.getAll());
            request.setAttribute("listaProductos", productos);
            request.setAttribute("busqueda", search == null ? "" : search);
            request.setAttribute("categoriaSeleccionada", categoryId == null ? "" : categoryId);
            request.getRequestDispatcher("/WEB-INF/tienda.jsp").forward(request, response);
        } catch (DaoException e) {
            getServletContext().log("No se pudo cargar el catálogo.", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "No se pudo cargar la tienda. Revisa la conexión a la base de datos.");
        }
    }
}
