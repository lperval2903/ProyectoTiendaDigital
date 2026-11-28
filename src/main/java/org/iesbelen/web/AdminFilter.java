package org.iesbelen.web;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.dao.DaoException;
import org.iesbelen.dao.UsuarioDAOImpl;
import org.iesbelen.model.Usuario;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        Usuario usuario = session == null ? null : (Usuario) session.getAttribute("usuario-logado");

        if (usuario != null) {
            try {
                Usuario currentUser = new UsuarioDAOImpl().find(usuario.getIdUsuario()).orElse(null);
                if (currentUser != null) {
                    session.setAttribute("usuario-logado", currentUser);
                    if ("admin".equals(currentUser.getRol())) {
                        chain.doFilter(request, response);
                        return;
                    }
                } else {
                    session.removeAttribute("usuario-logado");
                }
            } catch (DaoException e) {
                httpRequest.getServletContext().log("No se pudo validar el rol administrativo.", e);
                httpResponse.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "No se pudo validar el acceso a administración.");
                return;
            }
        }

        HttpSession loginSession = session == null ? httpRequest.getSession(true) : session;
        String target = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        if (httpRequest.getQueryString() != null) {
            target += "?" + httpRequest.getQueryString();
        }
        loginSession.setAttribute("rutaTrasLogin", target);
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/usuarios/login");
    }
}
