<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pedidos | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <div class="mb-8">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Administración</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">Pedidos</h1>
        <p class="mt-2 text-sm text-zinc-400">Consulta pedidos y actualiza su estado de envío.</p>
    </div>
    <section class="mb-8 rounded-xl border border-white/10 bg-panel p-5 sm:p-6">
        <h2 class="text-lg font-bold">Registrar pedido</h2>
        <form action="${pageContext.request.contextPath}/admin/pedidos/crear" method="post" class="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <label class="sr-only" for="idUsuarioPedido">ID del usuario</label>
            <input id="idUsuarioPedido" name="idUsuario" type="number" min="1" required placeholder="ID de usuario"
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            <label class="sr-only" for="fechaPedido">Fecha</label>
            <input id="fechaPedido" name="fecha" type="datetime-local" required
                   class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm text-zinc-300 outline-none focus:border-acid">
            <label class="sr-only" for="estadoPedido">Estado</label>
            <select id="estadoPedido" name="estado" required class="rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                <option value="pendiente">Pendiente</option>
                <option value="enviado">Enviado</option>
                <option value="entregado">Entregado</option>
            </select>
            <button class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Crear pedido</button>
        </form>
    </section>
    <section class="overflow-hidden rounded-xl border border-white/10 bg-panel">
        <div class="overflow-x-auto">
            <table class="w-full min-w-[760px] text-left text-sm">
                <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                <tr><th class="px-5 py-3">Pedido</th><th class="px-5 py-3">Usuario</th><th class="px-5 py-3">Fecha</th><th class="px-5 py-3">Total</th><th class="px-5 py-3">Estado</th><th class="px-5 py-3">Acciones</th></tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                <c:forEach var="pedido" items="${listaPedidos}">
                    <tr>
                        <td class="px-5 py-4 font-bold text-acid">#<c:out value="${pedido.idPedido}"/></td>
                        <td class="px-5 py-4 text-zinc-300">#<c:out value="${pedido.idUsuario}"/></td>
                        <td class="px-5 py-4 text-zinc-400"><c:out value="${pedido.fecha}"/></td>
                        <td class="px-5 py-4"><c:out value="${pedido.total}"/> €</td>
                        <td class="px-5 py-4">
                            <form id="editar-pedido-${pedido.idPedido}" action="${pageContext.request.contextPath}/admin/pedidos/editar" method="post">
                                <input type="hidden" name="idPedido" value="<c:out value='${pedido.idPedido}'/>">
                                <input type="hidden" name="idUsuario" value="<c:out value='${pedido.idUsuario}'/>">
                                <input type="hidden" name="fecha" value="<c:out value='${pedido.fecha}'/>">
                                <label class="sr-only" for="estado-${pedido.idPedido}">Estado del pedido</label>
                                <select id="estado-${pedido.idPedido}" name="estado" class="rounded-md border border-white/10 bg-ink px-3 py-2 text-xs outline-none focus:border-acid">
                                    <option value="pendiente" <c:if test="${pedido.estado == 'pendiente'}">selected</c:if>>Pendiente</option>
                                    <option value="enviado" <c:if test="${pedido.estado == 'enviado'}">selected</c:if>>Enviado</option>
                                    <option value="entregado" <c:if test="${pedido.estado == 'entregado'}">selected</c:if>>Entregado</option>
                                </select>
                            </form>
                        </td>
                        <td class="px-5 py-4">
                            <div class="flex gap-2">
                                <button form="editar-pedido-${pedido.idPedido}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Guardar</button>
                                <a href="${pageContext.request.contextPath}/admin/detallePedido?idPedido=${pedido.idPedido}" class="rounded-md border border-white/10 px-3 py-2 text-xs font-bold text-zinc-300 hover:border-acid hover:text-acid">Detalles</a>
                                <form action="${pageContext.request.contextPath}/admin/pedidos/borrar" method="post" onsubmit="return confirm('¿Eliminar este pedido?');">
                                    <input type="hidden" name="idPedido" value="<c:out value='${pedido.idPedido}'/>">
                                    <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaPedidos}">
                    <tr><td colspan="6" class="px-5 py-10 text-center text-sm text-zinc-500">No hay pedidos para mostrar.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>