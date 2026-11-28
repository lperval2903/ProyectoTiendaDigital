<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="border-b border-white/10 bg-panel px-4 py-2 text-center text-xs font-medium text-zinc-300">
    Ropa, periféricos y artículos de colección de Counter-Strike
</div>

<header class="relative z-10 border-b border-white/10 bg-ink/90">
    <nav class="mx-auto flex max-w-7xl items-center justify-between gap-4 px-5 py-5 lg:px-8" aria-label="Navegación principal">
        <a href="${pageContext.request.contextPath}/" class="flex shrink-0 items-center gap-2.5" aria-label="Xend Shop, inicio">
            <span class="grid h-9 w-9 place-items-center rounded-lg bg-acid text-sm font-black italic text-ink">X</span>
            <span class="text-lg font-extrabold tracking-tight">XEND <span class="text-acid">SHOP</span></span>
        </a>
        <div class="hidden items-center gap-8 text-sm font-medium text-zinc-400 md:flex">
            <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/">Inicio</a>
            <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/tienda">Tienda</a>
            <c:if test="${sessionScope['usuario-logado'].rol eq 'admin'}">
                <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/categorias">Administración</a>
                <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/productos">Productos</a>
                <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/usuarios">Usuarios</a>
                <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/pedidos">Pedidos</a>
            </c:if>
        </div>
        <div class="flex shrink-0 items-center gap-2">
        <a href="${pageContext.request.contextPath}/carrito" class="inline-flex items-center gap-2 rounded-lg border border-white/15 px-3 py-2.5 text-xs font-bold transition hover:border-acid hover:text-acid sm:px-4 sm:text-sm">
            <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 3h2l2.4 12.2a2 2 0 0 0 2 1.6h8.8a2 2 0 0 0 2-1.6L22 8H6"/><circle cx="10" cy="21" r="1"/><circle cx="19" cy="21" r="1"/></svg>
            <span>Carrito</span>
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope['usuario-logado']}">
                <form action="${pageContext.request.contextPath}/usuarios/logout" method="post">
                    <button class="rounded-lg bg-acid px-3 py-2.5 text-xs font-extrabold text-ink transition hover:bg-white sm:px-4 sm:text-sm" type="submit">Salir</button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/usuarios/login" class="rounded-lg bg-acid px-3 py-2.5 text-xs font-extrabold text-ink transition hover:bg-white sm:px-4 sm:text-sm">Entrar</a>
            </c:otherwise>
        </c:choose>
        </div>
    </nav>
    <div class="flex justify-center gap-6 border-t border-white/5 px-5 py-2.5 text-xs font-medium text-zinc-400 md:hidden">
        <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/">Inicio</a>
        <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/tienda">Tienda</a>
        <c:if test="${sessionScope['usuario-logado'].rol eq 'admin'}">
            <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/categorias">Admin</a>
            <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/admin/productos">Productos</a>
        </c:if>
    </div>
</header>