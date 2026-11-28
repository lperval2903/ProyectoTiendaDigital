<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Productos | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <div class="mb-8 flex flex-wrap items-end justify-between gap-4">
        <div>
            <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Catálogo Xend</p>
            <h1 class="display-font mt-2 text-5xl font-bold uppercase">Productos</h1>
            <p class="mt-2 text-sm text-zinc-400">Administra el inventario de la tienda.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/productos/crear" class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white">Añadir producto <span aria-hidden="true">+</span></a>
    </div>
    <section class="overflow-hidden rounded-xl border border-white/10 bg-panel">
        <div class="overflow-x-auto">
            <table class="w-full min-w-[850px] text-left text-sm">
                <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                <tr><th class="px-5 py-3">Producto</th><th class="px-5 py-3">Categoría (ID)</th><th class="px-5 py-3">Stock</th><th class="px-5 py-3">Precio (€)</th><th class="px-5 py-3">Acciones</th></tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                <c:forEach var="producto" items="${listaProductos}">
                    <tr>
                        <td class="px-5 py-4">
                            <form id="editar-producto-${producto.idProducto}" action="${pageContext.request.contextPath}/admin/productos/editar" method="post">
                                <input type="hidden" name="idProducto" value="<c:out value='${producto.idProducto}'/>">
                            </form>
                            <label class="sr-only" for="nombre-producto-${producto.idProducto}">Nombre</label>
                            <input form="editar-producto-${producto.idProducto}" id="nombre-producto-${producto.idProducto}" name="nombreProducto" required maxlength="150" value="<c:out value='${producto.nombreProducto}'/>"
                                   class="w-48 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                        </td>
                        <td class="px-5 py-4">
                            <label class="sr-only" for="categoria-producto-${producto.idProducto}">ID de categoría</label>
                            <input form="editar-producto-${producto.idProducto}" id="categoria-producto-${producto.idProducto}" name="idCategoria" type="number" min="1" required value="<c:out value='${producto.idCategoria}'/>"
                                   class="w-24 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                        </td>
                        <td class="px-5 py-4">
                            <label class="sr-only" for="stock-producto-${producto.idProducto}">Stock</label>
                            <input form="editar-producto-${producto.idProducto}" id="stock-producto-${producto.idProducto}" name="stock" type="number" min="0" required value="<c:out value='${producto.stock}'/>"
                                   class="w-24 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                        </td>
                        <td class="px-5 py-4">
                            <label class="sr-only" for="precio-producto-${producto.idProducto}">Precio en euros</label>
                            <input form="editar-producto-${producto.idProducto}" id="precio-producto-${producto.idProducto}" name="precio" type="number" min="0" step="0.01" required value="<c:out value='${producto.precio}'/>"
                                   class="w-28 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                        </td>
                        <td class="px-5 py-4">
                            <div class="flex gap-2">
                                <button form="editar-producto-${producto.idProducto}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Guardar</button>
                                <form action="${pageContext.request.contextPath}/admin/productos/borrar" method="post" onsubmit="return confirm('¿Eliminar este producto?');">
                                    <input type="hidden" name="idProducto" value="<c:out value='${producto.idProducto}'/>">
                                    <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaProductos}">
                    <tr><td colspan="5" class="px-5 py-10 text-center text-sm text-zinc-500">No hay productos para mostrar.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>