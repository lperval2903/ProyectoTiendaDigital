<footer class="border-t border-white/10 bg-[#070908]">
    <div class="mx-auto max-w-7xl px-5 py-12 lg:px-8">
        <div class="grid gap-10 sm:grid-cols-2 lg:grid-cols-[1.4fr_.8fr_.8fr]">
            <div>
                <a href="${pageContext.request.contextPath}/#inicio" class="inline-flex items-center gap-2.5 text-lg font-extrabold tracking-tight text-white" aria-label="Xend Shop, volver al inicio">
                    <span class="grid h-9 w-9 place-items-center rounded-lg bg-acid text-sm font-black italic text-ink">X</span>
                    XEND <span class="text-acid">SHOP</span>
                </a>
                <p class="mt-4 max-w-sm text-sm leading-6 text-zinc-500">
                    Tu próximo nivel empieza con el equipo adecuado. Periféricos y accesorios gaming para competir con ventaja.
                </p>
            </div>
            <div>
                <h2 class="text-xs font-extrabold uppercase tracking-[.18em] text-white">Explora</h2>
                <ul class="mt-4 space-y-3 text-sm text-zinc-500">
                    <li><a class="transition hover:text-acid" href="${pageContext.request.contextPath}/#productos">Productos destacados</a></li>
                    <li><a class="transition hover:text-acid" href="${pageContext.request.contextPath}/#categorias">Categorías</a></li>
                    <li><a class="transition hover:text-acid" href="${pageContext.request.contextPath}/#ventajas">Envíos y soporte</a></li>
                </ul>
            </div>
            <div>
                <h2 class="text-xs font-extrabold uppercase tracking-[.18em] text-white">Compra con confianza</h2>
                <p class="mt-4 text-sm leading-6 text-zinc-500">Envío gratis desde 99 €, cambios durante 30 días y soporte para ayudarte con tu setup.</p>
                <a href="${pageContext.request.contextPath}/#productos" class="mt-4 inline-flex items-center gap-2 text-sm font-bold text-acid transition hover:text-white">
                    Encuentra tu equipo <span aria-hidden="true">→</span>
                </a>
            </div>
        </div>
        <div class="mt-10 flex flex-col gap-3 border-t border-white/10 pt-5 text-xs text-zinc-600 sm:flex-row sm:items-center sm:justify-between">
            <p>© <%= java.time.Year.now().getValue() %> Xend Shop. Todos los derechos reservados.</p>
            <a class="transition hover:text-acid" href="${pageContext.request.contextPath}/#inicio">Volver arriba ↑</a>
        </div>
    </div>
</footer>