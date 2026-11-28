<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Categorías | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <div class="mb-8">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Catálogo</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">Categorías</h1>
        <p class="mt-2 text-sm text-zinc-400">Organiza el equipo gaming de Xend Shop.</p>
    </div>
    <section class="mb-8 rounded-xl border border-white/10 bg-panel p-5 sm:p-6">
        <h2 class="text-lg font-bold">Añadir categoría</h2>
        <form action="${pageContext.request.contextPath}/admin/categorias/crear" method="post" class="mt-4 flex flex-col gap-3 sm:flex-row">
            <label class="sr-only" for="nombreCategoria">Nombre de la categoría</label>
            <input id="nombreCategoria" name="nombreCategoria" required maxlength="100" placeholder="Ej. Teclados"
                   class="min-w-0 flex-1 rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm text-white outline-none placeholder:text-zinc-600 focus:border-acid">
            <button class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Crear categoría</button>
        </form>
    </section>
    <section class="overflow-hidden rounded-xl border border-white/10 bg-panel">
        <div class="border-b border-white/10 px-5 py-4"><h2 class="font-bold">Categorías disponibles</h2></div>
        <div class="overflow-x-auto">
            <table class="w-full min-w-[560px] text-left text-sm">
                <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                <tr><th class="px-5 py-3">ID</th><th class="px-5 py-3">Nombre</th><th class="px-5 py-3">Acciones</th></tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                <c:forEach var="categoria" items="${listaCategorias}">
                    <tr>
                        <td class="px-5 py-4 text-zinc-500"><c:out value="${categoria.idCategoria}"/></td>
                        <td class="px-5 py-4">
                            <form id="editar-categoria-${categoria.idCategoria}" action="${pageContext.request.contextPath}/admin/categorias/editar" method="post" class="flex items-center gap-2">
                                <input type="hidden" name="idCategoria" value="<c:out value='${categoria.idCategoria}'/>">
                                <label class="sr-only" for="nombre-categoria-${categoria.idCategoria}">Nombre</label>
                                <input id="nombre-categoria-${categoria.idCategoria}" name="nombreCategoria" required maxlength="100" value="<c:out value='${categoria.nombreCategoria}'/>"
                                       class="w-full rounded-md border border-white/10 bg-ink px-3 py-2 text-sm outline-none focus:border-acid">
                            </form>
                        </td>
                        <td class="px-5 py-4">
                            <div class="flex gap-2">
                                <button form="editar-categoria-${categoria.idCategoria}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Guardar</button>
                                <form action="${pageContext.request.contextPath}/admin/categorias/borrar" method="post" onsubmit="return confirm('¿Eliminar esta categoría?');">
                                    <input type="hidden" name="idCategoria" value="<c:out value='${categoria.idCategoria}'/>">
                                    <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaCategorias}">
                    <tr><td colspan="3" class="px-5 py-10 text-center text-sm text-zinc-500">Todavía no hay categorías.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>