package org.iesbelen.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.dao.DaoException;
import org.iesbelen.dao.UsuarioDAO;
import org.iesbelen.dao.UsuarioDAOImpl;
import org.iesbelen.model.Usuario;
import org.iesbelen.util.PasswordUtil;

import java.io.IOException;
import java.util.Locale;

@WebServlet("/usuarios/*")
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || "/login".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        } else if ("/registro".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        try {
            if ("/login".equals(path)) {
                login(request, response);
            } else if ("/registro".equals(path)) {
                register(request, response);
            } else if ("/logout".equals(path)) {
                logout(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (DaoException e) {
            getServletContext().log("Error al procesar autenticación de usuario.", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "No se pudo completar la operación de usuario. Revisa la base de datos.");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = parameter(request, "nombre");
        String password = request.getParameter("contrasena");
        if (username == null || password == null || password.isEmpty()) {
            request.setAttribute("error", "Introduce usuario y contraseña.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        java.util.Optional<Usuario> authenticated = usuarioDAO.authenticate(username, password);
        if (!authenticated.isPresent()) {
            request.setAttribute("error", "El usuario o la contraseña no son correctos.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        HttpSession oldSession = request.getSession(false);
        String target = oldSession == null ? null : (String) oldSession.getAttribute("rutaTrasLogin");
        Object cart = oldSession == null ? null : oldSession.getAttribute("carrito");
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession session = request.getSession(true);
        session.setAttribute("usuario-logado", authenticated.get());
        if (cart != null) {
            session.setAttribute("carrito", cart);
        }
        if (isLocalPath(target)) {
            response.sendRedirect(request.getContextPath() + target);
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = parameter(request, "nombre");
        String password = request.getParameter("contrasena");
        if (username == null || username.isEmpty() || username.length() > 20 || password == null || password.length() < 4) {
            request.setAttribute("error", "Indica un usuario de hasta 20 caracteres y una contraseña de al menos 4.");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }
        boolean usernameExists = usuarioDAO.getAll().stream()
                .anyMatch(usuario -> usuario.getNombre().equalsIgnoreCase(username));
        if (usernameExists) {
            request.setAttribute("error", "Ese nombre de usuario ya está registrado.");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(username);
        usuario.setContrasena(PasswordUtil.hash(password));
        usuario.setRol("cliente");
        usuarioDAO.create(usuario);
        response.sendRedirect(request.getContextPath() + "/usuarios/login?registrado=1");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }

    private String parameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value == null ? null : value.trim();
    }

    private boolean isLocalPath(String target) {
        return target != null && target.startsWith("/") && !target.startsWith("//")
                && !target.toLowerCase(Locale.ROOT).contains("%2f");
    }
}
