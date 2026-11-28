<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Carrito | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-5xl px-5 py-12 lg:px-8">
    <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Tu selección</p>
    <h1 class="display-font mt-2 text-5xl font-bold uppercase">Carrito</h1>
    <c:if test="${not empty mensajeCarrito}">
        <p role="status" class="mt-5 rounded-lg border border-amber-300/20 bg-amber-300/5 px-4 py-3 text-sm text-amber-200"><c:out value="${mensajeCarrito}"/></p>
    </c:if>

    <c:choose>
        <c:when test="${empty itemsCarrito}">
            <section class="mt-7 rounded-xl border border-white/10 bg-panel px-5 py-12 text-center">
                <p class="text-zinc-400">Todavía no has añadido productos.</p>
                <a href="${pageContext.request.contextPath}/tienda" class="mt-5 inline-flex rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink hover:bg-white">Volver a la tienda</a>
            </section>
        </c:when>
        <c:otherwise>
            <section class="mt-7 overflow-hidden rounded-xl border border-white/10 bg-panel">
                <div class="overflow-x-auto">
                    <table class="w-full min-w-[650px] text-left text-sm">
                        <thead class="bg-white/[.03] text-xs uppercase tracking-wider text-zinc-500">
                        <tr><th class="px-5 py-3">Producto</th><th class="px-5 py-3">Precio</th><th class="px-5 py-3">Cantidad</th><th class="px-5 py-3">Subtotal</th><th class="px-5 py-3"></th></tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                        <c:forEach var="item" items="${itemsCarrito}">
                            <tr>
                                <td class="px-5 py-4 font-semibold"><c:out value="${item.nombreProducto}"/></td>
                                <td class="px-5 py-4"><fmt:formatNumber value="${item.precio}" minFractionDigits="2" maxFractionDigits="2"/> €</td>
                                <td class="px-5 py-4">
                                    <form id="actualizar-${item.idProducto}" action="${pageContext.request.contextPath}/carrito/actualizar" method="post" class="flex items-center gap-2">
                                        <input type="hidden" name="idProducto" value="<c:out value='${item.idProducto}'/>">
                                        <label class="sr-only" for="cantidad-carrito-${item.idProducto}">Cantidad</label>
                                        <input id="cantidad-carrito-${item.idProducto}" name="cantidad" type="number" min="1" value="<c:out value='${item.cantidad}'/>" required
                                               class="w-20 rounded-md border border-white/10 bg-ink px-3 py-2 outline-none focus:border-acid">
                                    </form>
                                </td>
                                <td class="px-5 py-4 font-bold"><fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/> €</td>
                                <td class="px-5 py-4">
                                    <div class="flex gap-2">
                                        <button form="actualizar-${item.idProducto}" class="rounded-md border border-acid/30 px-3 py-2 text-xs font-bold text-acid hover:bg-acid hover:text-ink" type="submit">Actualizar</button>
                                        <form action="${pageContext.request.contextPath}/carrito/eliminar" method="post">
                                            <input type="hidden" name="idProducto" value="<c:out value='${item.idProducto}'/>">
                                            <button class="rounded-md border border-red-400/20 px-3 py-2 text-xs font-bold text-red-300 hover:bg-red-400 hover:text-ink" type="submit">Quitar</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="flex flex-col gap-4 border-t border-white/10 p-5 sm:flex-row sm:items-center sm:justify-between">
                    <a href="${pageContext.request.contextPath}/tienda" class="text-sm font-bold text-zinc-400 hover:text-acid">← Seguir comprando</a>
                    <div class="flex flex-col gap-3 sm:items-end">
                        <p class="text-lg font-extrabold">Total: <fmt:formatNumber value="${totalCarrito}" minFractionDigits="2" maxFractionDigits="2"/> €</p>
                        <form action="${pageContext.request.contextPath}/carrito/finalizar" method="post">
                            <button class="w-full rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white sm:w-auto" type="submit">Finalizar compra</button>
                        </form>
                        <c:if test="${empty sessionScope['usuario-logado']}">
                            <p class="text-xs text-zinc-500">Tendrás que iniciar sesión antes de finalizar.</p>
                        </c:if>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>
