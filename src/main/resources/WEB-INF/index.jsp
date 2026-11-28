<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#111312">
    <title>Xend Shop | Tienda Counter-Strike</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="bg-ink text-white antialiased selection:bg-acid selection:text-ink">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />

<main>
    <section id="inicio" class="relative isolate overflow-hidden border-b border-white/10">
        <div class="mx-auto max-w-7xl px-5 py-16 sm:py-20 lg:px-8 lg:py-24">
            <div class="max-w-3xl">
                <p class="mb-4 text-sm font-semibold text-acid">Xend Shop</p>
                <h1 class="max-w-2xl text-4xl font-bold leading-tight tracking-tight sm:text-5xl lg:text-6xl">
                    Ropa y accesorios de Counter-Strike
                </h1>
                <p class="mt-7 max-w-lg text-sm leading-7 text-zinc-400 sm:text-base">
                    Camisetas, periféricos y artículos para fans de Counter-Strike.
                </p>
                <div class="mt-8 flex flex-wrap items-center gap-4">
                    <a href="${pageContext.request.contextPath}/tienda" class="inline-flex items-center rounded-md bg-acid px-5 py-3 text-sm font-bold text-ink transition hover:bg-white">
                        Ver productos
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section id="categorias" class="mx-auto max-w-7xl px-5 py-14 lg:px-8 lg:py-20">
        <div class="mb-7 flex items-end justify-between">
            <div><p class="text-sm font-semibold text-acid">Catálogo</p><h2 class="mt-2 text-3xl font-bold sm:text-4xl">Explora la tienda</h2></div>
        </div>
        <div class="grid gap-3 sm:grid-cols-3">
            <a href="${pageContext.request.contextPath}/tienda?categoria=1" class="rounded-xl border border-white/10 bg-panel p-5 transition hover:border-acid/50">
                <p class="font-bold">Ropa y equipación</p>
                <p class="mt-2 text-sm text-zinc-400">Camisetas, sudaderas y accesorios para fans.</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda?categoria=2" class="rounded-xl border border-white/10 bg-panel p-5 transition hover:border-acid/50">
                <p class="font-bold">Periféricos y setup</p>
                <p class="mt-2 text-sm text-zinc-400">Accesorios para completar tu espacio de juego.</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda?categoria=3" class="rounded-xl border border-white/10 bg-panel p-5 transition hover:border-acid/50">
                <p class="font-bold">Coleccionismo y accesorios</p>
                <p class="mt-2 text-sm text-zinc-400">Pines, llaveros y artículos de colección.</p>
            </a>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>