<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tienda | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
    <section id="categorias" class="mb-10">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Xend Shop</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase sm:text-6xl">Equipo para competir</h1>
        <p class="mt-2 text-sm text-zinc-400">Explora el catálogo y prepara tu próximo setup.</p>
        <div class="mt-6 flex flex-wrap gap-2">
            <a href="${pageContext.request.contextPath}/tienda" class="rounded-full border border-white/15 px-4 py-2 text-xs font-bold transition hover:border-acid hover:text-acid">Todo</a>
            <c:forEach var="categoria" items="${listaCategorias}">
                <a href="${pageContext.request.contextPath}/tienda?categoria=${categoria.idCategoria}"
                   class="rounded-full border border-white/15 px-4 py-2 text-xs font-bold transition hover:border-acid hover:text-acid">
                    <c:out value="${categoria.nombreCategoria}"/>
                </a>
            </c:forEach>
        </div>
    </section>

    <form action="${pageContext.request.contextPath}/tienda" method="get" class="mb-8 flex max-w-xl gap-2">
        <label for="buscar" class="sr-only">Buscar productos</label>
        <input id="buscar" name="buscar" value="<c:out value='${busqueda}'/>" placeholder="Buscar equipo..."
               class="min-w-0 flex-1 rounded-lg border border-white/10 bg-panel px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
        <button class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Buscar</button>
    </form>

    <section class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <c:forEach var="producto" items="${listaProductos}">
            <article class="overflow-hidden rounded-xl border border-white/10 bg-panel transition hover:-translate-y-1 hover:border-acid/40">
                <div class="flex h-40 items-center justify-center bg-gradient-to-br from-acid/10 via-panel to-black">
                    <span class="display-font text-5xl font-bold uppercase text-white/10">XEND</span>
                </div>
                <div class="p-5">
                    <p class="text-[10px] font-bold uppercase tracking-[.18em] text-acid">Producto #<c:out value="${producto.idProducto}"/></p>
                    <h2 class="mt-2 text-lg font-bold"><c:out value="${producto.nombreProducto}"/></h2>
                    <div class="mt-3 flex items-center justify-between">
                        <span class="text-xl font-extrabold"><fmt:formatNumber value="${producto.precio}" minFractionDigits="2" maxFractionDigits="2"/> €</span>
                        <span class="text-xs text-zinc-500">Stock: <c:out value="${producto.stock}"/></span>
                    </div>
                    <c:choose>
                        <c:when test="${producto.stock gt 0}">
                            <form action="${pageContext.request.contextPath}/carrito/agregar" method="post" class="mt-4 flex gap-2">
                                <input type="hidden" name="idProducto" value="<c:out value='${producto.idProducto}'/>">
                                <label for="cantidad-${producto.idProducto}" class="sr-only">Cantidad</label>
                                <input id="cantidad-${producto.idProducto}" name="cantidad" type="number" min="1" max="<c:out value='${producto.stock}'/>" value="1" required
                                       class="w-20 rounded-lg border border-white/10 bg-ink px-3 py-2.5 text-sm outline-none focus:border-acid">
                                <button class="flex-1 rounded-lg bg-acid px-4 py-2.5 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Añadir al carrito</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p class="mt-4 rounded-lg border border-red-400/20 px-4 py-2.5 text-center text-sm font-bold text-red-300">Agotado</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </article>
        </c:forEach>
        <c:if test="${empty listaProductos}">
            <p class="col-span-full rounded-xl border border-white/10 bg-panel px-5 py-12 text-center text-sm text-zinc-500">No encontramos productos con esos filtros.</p>
        </c:if>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>
