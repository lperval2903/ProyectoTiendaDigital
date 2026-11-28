<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#111312">
    <title>Xend Shop | Equipamiento gaming</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="bg-ink text-white antialiased selection:bg-acid selection:text-ink">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />

<main>
    <section id="inicio" class="relative isolate overflow-hidden border-b border-white/10">
        <div class="mx-auto grid max-w-7xl items-center gap-10 px-5 py-16 sm:py-20 lg:grid-cols-[1fr_.95fr] lg:px-8 lg:py-24">
            <div class="relative z-10">
                <p class="mb-4 text-sm font-semibold text-acid">Xend Shop</p>
                <h1 class="max-w-2xl text-4xl font-bold leading-tight tracking-tight sm:text-5xl lg:text-6xl">
                    Equipamiento gaming para tu setup
                </h1>
                <p class="mt-7 max-w-lg text-sm leading-7 text-zinc-400 sm:text-base">
                    Encuentra periféricos, audio y accesorios para jugar y trabajar con comodidad.
                </p>
                <div class="mt-8 flex flex-wrap items-center gap-4">
                    <a href="${pageContext.request.contextPath}/tienda" class="inline-flex items-center rounded-md bg-acid px-5 py-3 text-sm font-bold text-ink transition hover:bg-white">
                        Ver productos
                    </a>
                </div>
            </div>
            <div class="relative mx-auto w-full max-w-xl">
                <div class="relative overflow-hidden rounded-2xl border border-white/10 bg-panel">
                    <img class="h-[300px] w-full object-cover sm:h-[380px]" src="https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&amp;fit=crop&amp;w=1200&amp;q=85" alt="Setup gaming con equipo y monitor">
                </div>
            </div>
        </div>
    </section>

    <section id="categorias" class="mx-auto max-w-7xl px-5 py-14 lg:px-8 lg:py-20">
        <div class="mb-7 flex items-end justify-between">
            <div><p class="text-sm font-semibold text-acid">Catálogo</p><h2 class="mt-2 text-3xl font-bold sm:text-4xl">Compra por categoría</h2></div>
        </div>
        <div class="grid grid-cols-2 gap-3 md:grid-cols-4">
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-5 grid h-10 w-10 place-items-center rounded-md bg-acid/10 text-acid">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="6" width="18" height="12" rx="2"/><path d="M7 10h4m-2-2v4m6-1h.01M17 9h.01"/></svg>
                </span>
                <p class="font-bold">Teclados</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-5 grid h-10 w-10 place-items-center rounded-md bg-acid/10 text-acid">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="6" y="3" width="12" height="18" rx="6"/><path d="M12 7v4m-3 1h6"/></svg>
                </span>
                <p class="font-bold">Ratones</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-5 grid h-10 w-10 place-items-center rounded-md bg-acid/10 text-acid">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 13v-2a8 8 0 0 1 16 0v2"/><rect x="3" y="12" width="5" height="8" rx="2"/><rect x="16" y="12" width="5" height="8" rx="2"/></svg>
                </span>
                <p class="font-bold">Audio</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-5 grid h-10 w-10 place-items-center rounded-md bg-acid/10 text-acid">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 5h16v12H4zM8 21h8m-4-4v4"/></svg>
                </span>
                <p class="font-bold">Monitores</p>
            </a>
        </div>
    </section>

    <section id="productos" class="border-y border-white/10 bg-[#0b0e0c]">
        <div class="mx-auto max-w-7xl px-5 py-14 lg:px-8 lg:py-20">
            <div class="mb-8 flex items-end justify-between gap-4">
                <div><p class="text-sm font-semibold text-acid">Selección</p><h2 class="mt-2 text-3xl font-bold sm:text-4xl">Productos destacados</h2></div>
                <a href="${pageContext.request.contextPath}/tienda" class="hidden text-xs font-bold text-acid transition hover:text-white sm:inline-flex sm:items-center sm:gap-2">Ver todo <span aria-hidden="true">→</span></a>
            </div>
            <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1613141412501-9012977f1969?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Teclado mecánico gaming" loading="lazy">
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver teclado mecánico en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-xs text-zinc-500">Teclados</p><h3 class="mt-1 font-bold">Mech Pro X87</h3><p class="mt-3 font-bold">89,99 €</p></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Ratón gaming de precisión" loading="lazy">
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver ratón gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-xs text-zinc-500">Ratones</p><h3 class="mt-1 font-bold">Phantom Aim 2</h3><p class="mt-3 font-bold">59,90 €</p></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1599669454699-248893623440?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Auriculares gaming con micrófono" loading="lazy">
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver auriculares gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-xs text-zinc-500">Audio</p><h3 class="mt-1 font-bold">Headset Vortex 7.1</h3><p class="mt-3 font-bold">74,50 €</p></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Monitor gaming de alta frecuencia" loading="lazy">
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver monitor gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-xs text-zinc-500">Monitores</p><h3 class="mt-1 font-bold">Rift 27″ 180Hz</h3><p class="mt-3 font-bold">229,00 €</p></div>
                </article>
            </div>
        </div>
    </section>

    <section id="ventajas" class="mx-auto grid max-w-7xl gap-5 px-5 py-12 sm:grid-cols-3 lg:px-8">
        <div class="flex items-center gap-4 rounded-xl border border-white/10 p-4">
            <span class="grid h-11 w-11 shrink-0 place-items-center rounded-lg bg-acid/10 text-acid"><svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M3 7h11v10H3zM14 10h4l3 3v4h-7z"/><circle cx="7.5" cy="19" r="1.5"/><circle cx="18" cy="19" r="1.5"/></svg></span>
            <div><p class="text-sm font-bold">Envío rápido y seguro</p><p class="mt-1 text-xs text-zinc-500">Gratis desde 99 €</p></div>
        </div>
        <div class="flex items-center gap-4 rounded-xl border border-white/10 p-4">
            <span class="grid h-11 w-11 shrink-0 place-items-center rounded-lg bg-acid/10 text-acid"><svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M12 3 4 6v5c0 5 3.4 8.5 8 10 4.6-1.5 8-5 8-10V6z"/><path d="m9 12 2 2 4-4"/></svg></span>
            <div><p class="text-sm font-bold">Compra con confianza</p><p class="mt-1 text-xs text-zinc-500">30 días para cambios</p></div>
        </div>
        <div class="flex items-center gap-4 rounded-xl border border-white/10 p-4">
            <span class="grid h-11 w-11 shrink-0 place-items-center rounded-lg bg-acid/10 text-acid"><svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 4h16v12H7l-3 3z"/><path d="M8 9h8m-8 4h5"/></svg></span>
            <div><p class="text-sm font-bold">Estamos para ayudarte</p><p class="mt-1 text-xs text-zinc-500">Soporte gamer de verdad</p></div>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>