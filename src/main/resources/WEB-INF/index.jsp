<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#080a09">
    <title>Xend Shop | Equipamiento para ganar</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        ink: '#080a09',
                        panel: '#101411',
                        acid: '#b6ff3b'
                    },
                    fontFamily: {
                        sans: ['Inter', 'ui-sans-serif', 'system-ui']
                    }
                }
            }
        };
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@600;700;800;900&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .display-font { font-family: 'Barlow Condensed', sans-serif; }
        .hero-grid {
            background-image: linear-gradient(rgba(182,255,59,.045) 1px, transparent 1px), linear-gradient(90deg, rgba(182,255,59,.045) 1px, transparent 1px);
            background-size: 44px 44px;
            mask-image: linear-gradient(to bottom, black, transparent 90%);
        }
        .neon-shadow { box-shadow: 0 0 35px rgba(182,255,59,.18); }
        .product-image { transition: transform .45s cubic-bezier(.2,.8,.2,1); }
        .product-card:hover .product-image { transform: scale(1.06); }
    </style>
</head>
<body class="bg-ink text-white antialiased selection:bg-acid selection:text-ink">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />

<main>
    <section id="inicio" class="relative isolate overflow-hidden border-b border-white/10">
        <div class="hero-grid absolute inset-0 -z-10"></div>
        <div class="absolute -right-36 top-12 -z-10 h-96 w-96 rounded-full bg-acid/10 blur-[120px]"></div>
        <div class="mx-auto grid max-w-7xl items-center gap-10 px-5 py-16 sm:py-20 lg:grid-cols-[1fr_.95fr] lg:px-8 lg:py-24">
            <div class="relative z-10">
                <div class="mb-6 inline-flex items-center gap-2 rounded-full border border-acid/25 bg-acid/5 px-3 py-1.5 text-[10px] font-bold uppercase tracking-[.2em] text-acid sm:text-xs">
                    <span class="h-1.5 w-1.5 animate-pulse rounded-full bg-acid"></span>
                    Equipamiento para competir
                </div>
                <h1 class="display-font max-w-2xl text-6xl font-black uppercase leading-[.88] tracking-tight sm:text-7xl lg:text-8xl">
                    Juega en<br>otra <span class="text-acid">liga.</span>
                </h1>
                <p class="mt-7 max-w-lg text-sm leading-7 text-zinc-400 sm:text-base">
                    El gear que marca la diferencia. Periféricos, audio y accesorios elegidos para que cada partida cuente.
                </p>
                <div class="mt-8 flex flex-wrap items-center gap-4">
                    <a href="${pageContext.request.contextPath}/tienda" class="neon-shadow inline-flex items-center gap-3 rounded-lg bg-acid px-6 py-3.5 text-sm font-extrabold text-ink transition hover:bg-white">
                        Explorar productos
                        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14m-7-7 7 7-7 7"/></svg>
                    </a>
                    <span class="text-xs font-medium text-zinc-500">TOP GEAR. CERO EXCUSAS.</span>
                </div>
                <div class="mt-12 flex gap-8 border-t border-white/10 pt-6">
                    <div><p class="text-xl font-extrabold">+2.4k</p><p class="mt-1 text-[10px] uppercase tracking-widest text-zinc-500">Gamers equipados</p></div>
                    <div><p class="text-xl font-extrabold">4.9<span class="ml-1 text-acid">★</span></p><p class="mt-1 text-[10px] uppercase tracking-widest text-zinc-500">Valoración media</p></div>
                    <div><p class="text-xl font-extrabold">24/7</p><p class="mt-1 text-[10px] uppercase tracking-widest text-zinc-500">Modo competitivo</p></div>
                </div>
            </div>
            <div class="relative mx-auto w-full max-w-xl">
                <div class="absolute -inset-5 rounded-3xl bg-acid/10 blur-3xl"></div>
                <div class="relative overflow-hidden rounded-2xl border border-white/10 bg-panel">
                    <img class="h-[340px] w-full object-cover sm:h-[440px]" src="https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&amp;fit=crop&amp;w=1200&amp;q=85" alt="Setup gaming con iluminación verde y equipo de alto rendimiento">
                    <div class="absolute inset-0 bg-gradient-to-t from-ink via-ink/10 to-transparent"></div>
                    <div class="absolute left-5 top-5 rounded-full border border-acid/30 bg-ink/70 px-3 py-1.5 text-[10px] font-bold uppercase tracking-[.18em] text-acid backdrop-blur">Setup destacado</div>
                    <div class="absolute bottom-0 flex w-full items-end justify-between p-5 sm:p-7">
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-[.2em] text-acid">Tu próxima ventaja</p>
                            <p class="display-font mt-1 text-4xl font-bold uppercase sm:text-5xl">Nace aquí.</p>
                        </div>
                        <span class="grid h-11 w-11 place-items-center rounded-full border border-white/20 bg-white/10 backdrop-blur" aria-hidden="true">
                            <svg class="h-5 w-5 text-acid" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M7 17 17 7M7 7h10v10"/></svg>
                        </span>
                    </div>
                </div>
                <div class="absolute -bottom-5 -left-4 hidden items-center gap-3 rounded-xl border border-white/10 bg-[#151a15] p-3 shadow-2xl sm:flex">
                    <span class="grid h-10 w-10 place-items-center rounded-lg bg-acid/10 text-acid">
                        <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M6 12h4l2-7 3 14 2-7h3"/></svg>
                    </span>
                    <div><p class="text-xs font-bold">Rendimiento sin lag</p><p class="mt-1 text-[10px] text-zinc-500">Listo para el siguiente nivel</p></div>
                </div>
            </div>
        </div>
    </section>

    <section id="categorias" class="mx-auto max-w-7xl px-5 py-14 lg:px-8 lg:py-20">
        <div class="mb-7 flex items-end justify-between">
            <div><p class="text-[10px] font-bold uppercase tracking-[.22em] text-acid">Encuentra tu loadout</p><h2 class="display-font mt-2 text-4xl font-bold uppercase sm:text-5xl">Elige tu categoría</h2></div>
            <span class="hidden text-xs text-zinc-500 sm:block">Todo lo que necesitas para competir</span>
        </div>
        <div class="grid grid-cols-2 gap-3 md:grid-cols-4">
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-7 grid h-10 w-10 place-items-center rounded-lg bg-acid/10 text-acid transition group-hover:bg-acid group-hover:text-ink">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="6" width="18" height="12" rx="2"/><path d="M7 10h4m-2-2v4m6-1h.01M17 9h.01"/></svg>
                </span>
                <p class="font-bold">Teclados</p><p class="mt-1 text-xs text-zinc-500">Precisión en cada tecla</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-7 grid h-10 w-10 place-items-center rounded-lg bg-acid/10 text-acid transition group-hover:bg-acid group-hover:text-ink">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="6" y="3" width="12" height="18" rx="6"/><path d="M12 7v4m-3 1h6"/></svg>
                </span>
                <p class="font-bold">Ratones</p><p class="mt-1 text-xs text-zinc-500">Tu aim, tu ventaja</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-7 grid h-10 w-10 place-items-center rounded-lg bg-acid/10 text-acid transition group-hover:bg-acid group-hover:text-ink">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 13v-2a8 8 0 0 1 16 0v2"/><rect x="3" y="12" width="5" height="8" rx="2"/><rect x="16" y="12" width="5" height="8" rx="2"/></svg>
                </span>
                <p class="font-bold">Audio</p><p class="mt-1 text-xs text-zinc-500">Escucha antes que nadie</p>
            </a>
            <a href="${pageContext.request.contextPath}/tienda" class="group rounded-xl border border-white/10 bg-panel p-4 transition hover:border-acid/50 sm:p-5">
                <span class="mb-7 grid h-10 w-10 place-items-center rounded-lg bg-acid/10 text-acid transition group-hover:bg-acid group-hover:text-ink">
                    <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 5h16v12H4zM8 21h8m-4-4v4"/></svg>
                </span>
                <p class="font-bold">Monitores</p><p class="mt-1 text-xs text-zinc-500">Cada frame importa</p>
            </a>
        </div>
    </section>

    <section id="productos" class="border-y border-white/10 bg-[#0b0e0c]">
        <div class="mx-auto max-w-7xl px-5 py-14 lg:px-8 lg:py-20">
            <div class="mb-8 flex items-end justify-between gap-4">
                <div><p class="text-[10px] font-bold uppercase tracking-[.22em] text-acid">Selección de la semana</p><h2 class="display-font mt-2 text-4xl font-bold uppercase sm:text-5xl">Favoritos de la arena</h2></div>
                <a href="${pageContext.request.contextPath}/tienda" class="hidden text-xs font-bold text-acid transition hover:text-white sm:inline-flex sm:items-center sm:gap-2">Ver todo <span aria-hidden="true">→</span></a>
            </div>
            <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel transition hover:-translate-y-1 hover:border-acid/40">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1613141412501-9012977f1969?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Teclado mecánico gaming" loading="lazy">
                        <span class="absolute left-3 top-3 rounded bg-acid px-2 py-1 text-[9px] font-black uppercase tracking-wider text-ink">Bestseller</span>
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver teclado mecánico en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-[9px] font-bold uppercase tracking-[.18em] text-zinc-500">Teclados</p><h3 class="mt-1 font-bold">Mech Pro X87</h3><div class="mt-3 flex items-center justify-between"><span class="font-extrabold">89,99 €</span><span class="text-xs text-acid">★★★★★ <span class="text-zinc-500">(128)</span></span></div></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel transition hover:-translate-y-1 hover:border-acid/40">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Ratón gaming de precisión" loading="lazy">
                        <span class="absolute left-3 top-3 rounded border border-white/20 bg-ink/80 px-2 py-1 text-[9px] font-black uppercase tracking-wider">Ultraligero</span>
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver ratón gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-[9px] font-bold uppercase tracking-[.18em] text-zinc-500">Ratones</p><h3 class="mt-1 font-bold">Phantom Aim 2</h3><div class="mt-3 flex items-center justify-between"><span class="font-extrabold">59,90 €</span><span class="text-xs text-acid">★★★★★ <span class="text-zinc-500">(96)</span></span></div></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel transition hover:-translate-y-1 hover:border-acid/40">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1599669454699-248893623440?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Auriculares gaming con micrófono" loading="lazy">
                        <span class="absolute left-3 top-3 rounded border border-white/20 bg-ink/80 px-2 py-1 text-[9px] font-black uppercase tracking-wider">Nuevo</span>
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver auriculares gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-[9px] font-bold uppercase tracking-[.18em] text-zinc-500">Audio</p><h3 class="mt-1 font-bold">Headset Vortex 7.1</h3><div class="mt-3 flex items-center justify-between"><span class="font-extrabold">74,50 €</span><span class="text-xs text-acid">★★★★★ <span class="text-zinc-500">(74)</span></span></div></div>
                </article>
                <article class="product-card overflow-hidden rounded-xl border border-white/10 bg-panel transition hover:-translate-y-1 hover:border-acid/40">
                    <div class="relative h-52 overflow-hidden bg-[#171c17]">
                        <img class="product-image h-full w-full object-cover" src="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&amp;fit=crop&amp;w=700&amp;q=80" alt="Monitor gaming de alta frecuencia" loading="lazy">
                        <span class="absolute left-3 top-3 rounded bg-acid px-2 py-1 text-[9px] font-black uppercase tracking-wider text-ink">-15%</span>
                        <a href="${pageContext.request.contextPath}/tienda" class="absolute bottom-3 right-3 grid h-9 w-9 place-items-center rounded-full border border-white/15 bg-ink/80 text-white transition hover:bg-acid hover:text-ink" aria-label="Ver monitor gaming en la tienda">+</a>
                    </div>
                    <div class="p-4"><p class="text-[9px] font-bold uppercase tracking-[.18em] text-zinc-500">Monitores</p><h3 class="mt-1 font-bold">Rift 27″ 180Hz</h3><div class="mt-3 flex items-center justify-between"><span class="font-extrabold">229,00 €</span><span class="text-xs text-acid">★★★★★ <span class="text-zinc-500">(51)</span></span></div></div>
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