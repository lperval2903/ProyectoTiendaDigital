<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Usuarios | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <div class="mb-8">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Administración</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">Usuarios</h1>
        <p class="mt-2 text-sm text-zinc-400">Gestiona las cuentas y sus permisos. Las contraseñas no se muestran.</p>
    </div>
    <section class="mb-8 rounded-xl border border-white/10 bg-panel p-5 sm:p-6">
        <h2 class="text-lg font-bold">Crear usuario</h2>
        <form action="${pageContext.request.contextPath}/admin/usuarios/crear" method="post" class="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <label class="sr-only" for="nombreUsuario">Nombre de usuario</label>
            <input id="nombreUsuario" name="nombre" required maxlength="20" autocomplete="username" placeholder="Nombre de usuario"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="contrasenaUsuario">Contraseña</label>
            <input id="contrasenaUsuario" name="contrasena" required autocomplete="new-password" type="password" placeholder="Contraseña"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="rolUsuario">Rol</label>
            <select id="rolUsuario" name="rol" required class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                <option value="cliente">Usuario</option>
                <option value="admin">Administrador</option>
            </select>
            <button class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Crear cuenta</button>
        </form>
    </section>
    <section class="overflow-hidden rounded-xl border border-white/10 bg-panel">
        <div class="overflow-x-auto">
            <table class="w-full min-w-[650px] text-left text-sm">
                <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                <tr><th class="px-5 py-3">ID</th><th class="px-5 py-3">Usuario</th><th class="px-5 py-3">Rol</th><th class="px-5 py-3">Cambiar rol</th><th class="px-5 py-3">Acciones</th></tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                <c:forEach var="usuario" items="${listaUsuarios}">
                    <tr>
                        <td class="px-5 py-4 text-zinc-500"><c:out value="${usuario.idUsuario}"/></td>
                        <td class="px-5 py-4 font-semibold"><c:out value="${usuario.nombre}"/></td>
                        <td class="px-5 py-4"><span class="rounded-full border border-acid/20 bg-acid/5 px-2.5 py-1 text-xs text-acid"><c:out value="${usuario.rol}"/></span></td>
                        <td class="px-5 py-4">
                            <form id="editar-usuario-${usuario.idUsuario}" action="${pageContext.request.contextPath}/admin/usuarios/editar" method="post" class="flex items-center gap-2">
                                <input type="hidden" name="idUsuario" value="<c:out value='${usuario.idUsuario}'/>">
                                <input type="hidden" name="nombre" value="<c:out value='${usuario.nombre}'/>">
                                <label class="sr-only" for="rol-${usuario.idUsuario}">Nuevo rol</label>
                                <select id="rol-${usuario.idUsuario}" name="rol" class="rounded-md border border-white/10 bg-ink px-3 py-2 text-xs outline-none focus:border-acid">
                                    <option value="cliente" <c:if test="${usuario.rol == 'cliente'}">selected</c:if>>Usuario</option>
                                    <option value="admin" <c:if test="${usuario.rol == 'admin'}">selected</c:if>>Administrador</option>
                                </select>
                            </form>
                        </td>
                        <td class="px-5 py-4">
                            <div class="flex gap-2">
                                <button form="editar-usuario-${usuario.idUsuario}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Guardar</button>
                                <form action="${pageContext.request.contextPath}/admin/usuarios/borrar" method="post" onsubmit="return confirm('¿Eliminar esta cuenta?');">
                                    <input type="hidden" name="idUsuario" value="<c:out value='${usuario.idUsuario}'/>">
                                    <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaUsuarios}">
                    <tr><td colspan="5" class="px-5 py-10 text-center text-sm text-zinc-500">No hay usuarios para mostrar.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>