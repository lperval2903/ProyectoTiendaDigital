<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalles del pedido | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <div class="mb-8 flex flex-wrap items-end justify-between gap-4">
        <div>
            <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Relación pedido-producto</p>
            <h1 class="display-font mt-2 text-5xl font-bold uppercase">Detalles del pedido</h1>
            <p class="mt-2 text-sm text-zinc-400">Cada línea vincula un pedido con un producto, su cantidad y precio.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/pedidos" class="text-sm font-bold text-acid hover:text-white">← Volver a pedidos</a>
    </div>
    <section class="mb-8 rounded-xl border border-white/10 bg-panel p-5 sm:p-6">
        <h2 class="text-lg font-bold">Añadir producto al pedido</h2>
        <form action="${pageContext.request.contextPath}/admin/detallePedido/crear" method="post" class="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-5">
            <label class="sr-only" for="idPedidoDetalle">ID del pedido</label>
            <input id="idPedidoDetalle" name="idPedido" type="number" min="1" required placeholder="ID de pedido"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="idProductoDetalle">ID del producto</label>
            <input id="idProductoDetalle" name="idProducto" type="number" min="1" required placeholder="ID de producto"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="cantidadDetalle">Cantidad</label>
            <input id="cantidadDetalle" name="cantidad" type="number" min="1" required placeholder="Cantidad"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="precioUdDetalle">Precio unitario en euros</label>
            <input id="precioUdDetalle" name="precioUd" type="number" min="0" step="0.01" required placeholder="Precio unitario (€)"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <button class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Añadir línea</button>
        </form>
    </section>
    <section class="overflow-hidden rounded-xl border border-white/10 bg-panel">
        <div class="overflow-x-auto">
            <table class="w-full min-w-[750px] text-left text-sm">
                <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                <tr><th class="px-5 py-3">Detalle</th><th class="px-5 py-3">Pedido</th><th class="px-5 py-3">Producto</th><th class="px-5 py-3">Cantidad</th><th class="px-5 py-3">Precio unitario</th><th class="px-5 py-3">Acciones</th></tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                <c:forEach var="detalle" items="${listaDetallesPedido}">
                    <tr>
                        <td class="px-5 py-4 text-zinc-500"><c:out value="${detalle.idDetalle}"/></td>
                        <td class="px-5 py-4">#<c:out value="${detalle.idPedido}"/></td>
                        <td class="px-5 py-4">#<c:out value="${detalle.idProducto}"/></td>
                        <td class="px-5 py-4">
                            <form id="editar-detalle-${detalle.idDetalle}" action="${pageContext.request.contextPath}/admin/detallePedido/editar" method="post">
                                <input type="hidden" name="idDetalle" value="<c:out value='${detalle.idDetalle}'/>">
                                <input type="hidden" name="idPedido" value="<c:out value='${detalle.idPedido}'/>">
                                <input type="hidden" name="idProducto" value="<c:out value='${detalle.idProducto}'/>">
                                <label class="sr-only" for="cantidad-${detalle.idDetalle}">Cantidad</label>
                                <input id="cantidad-${detalle.idDetalle}" name="cantidad" type="number" min="1" required value="<c:out value='${detalle.cantidad}'/>"
                                       class="w-24 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                            </form>
                        </td>
                        <td class="px-5 py-4">
                            <label class="sr-only" for="precio-${detalle.idDetalle}">Precio unitario</label>
                            <input form="editar-detalle-${detalle.idDetalle}" id="precio-${detalle.idDetalle}" name="precioUd" type="number" min="0" step="0.01" required value="<c:out value='${detalle.precioUd}'/>"
                                   class="w-28 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                        </td>
                        <td class="px-5 py-4">
                            <div class="flex gap-2">
                                <button form="editar-detalle-${detalle.idDetalle}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Guardar</button>
                                <form action="${pageContext.request.contextPath}/admin/detallePedido/borrar" method="post" onsubmit="return confirm('¿Eliminar esta línea del pedido?');">
                                    <input type="hidden" name="idDetalle" value="<c:out value='${detalle.idDetalle}'/>">
                                    <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaDetallesPedido}">
                    <tr><td colspan="6" class="px-5 py-10 text-center text-sm text-zinc-500">No hay líneas de pedido para mostrar.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>