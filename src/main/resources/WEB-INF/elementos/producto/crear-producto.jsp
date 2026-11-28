<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Añadir producto | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-3xl px-5 py-12 lg:px-8">
    <a href="${pageContext.request.contextPath}/admin/productos" class="text-sm font-bold text-acid hover:text-white">← Volver a productos</a>
    <section class="mt-5 rounded-xl border border-white/10 bg-panel p-6 sm:p-8">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Catálogo Xend</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">Añadir producto</h1>
        <p class="mt-2 text-sm text-zinc-400">Completa los datos del nuevo producto.</p>
        <form action="${pageContext.request.contextPath}/admin/productos/crear" method="post" class="mt-7 space-y-5">
            <div>
                <label for="nombreProducto" class="mb-2 block text-sm font-semibold">Nombre del producto</label>
                <input id="nombreProducto" name="nombreProducto" required maxlength="150" placeholder="Ej. Mech Pro X87"
                       class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none placeholder:text-zinc-600 focus:border-acid">
            </div>
            <div>
                <label for="idCategoria" class="mb-2 block text-sm font-semibold">Categoría</label>
                <select id="idCategoria" name="idCategoria" required class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                    <option value="" disabled selected>Selecciona una categoría</option>
                    <c:forEach var="categoria" items="${listaCategorias}">
                        <option value="<c:out value='${categoria.idCategoria}'/>"><c:out value="${categoria.nombreCategoria}"/></option>
                    </c:forEach>
                </select>
                <c:if test="${empty listaCategorias}">
                    <p class="mt-2 text-xs text-amber-300">No hay categorías disponibles. Crea una antes de añadir productos.</p>
                </c:if>
            </div>
            <div class="grid gap-5 sm:grid-cols-2">
                <div>
                    <label for="stock" class="mb-2 block text-sm font-semibold">Stock</label>
                    <input id="stock" name="stock" type="number" min="0" required value="0"
                           class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                </div>
                <div>
                    <label for="precio" class="mb-2 block text-sm font-semibold">Precio (€)</label>
                    <input id="precio" name="precio" type="number" min="0" step="0.01" required placeholder="0,00"
                           class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                </div>
            </div>
            <div class="flex flex-wrap gap-3 pt-2">
                <button type="submit" <c:if test="${empty listaCategorias}">disabled</c:if>
                        class="rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white disabled:cursor-not-allowed disabled:opacity-40">Crear producto</button>
                <a href="${pageContext.request.contextPath}/admin/productos" class="rounded-lg border border-white/10 px-5 py-3 text-sm font-bold text-zinc-300 transition hover:border-acid hover:text-acid">Cancelar</a>
            </div>
        </form>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>
