<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Compra completada | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-2xl px-5 py-16">
    <section class="rounded-xl border border-acid/20 bg-panel p-8 text-center sm:p-12">
        <span class="mx-auto grid h-14 w-14 place-items-center rounded-full bg-acid text-2xl font-black text-ink" aria-hidden="true">✓</span>
        <p class="mt-6 text-xs font-bold uppercase tracking-[.2em] text-acid">Compra completada</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">¡Gracias por tu pedido!</h1>
        <p class="mt-4 text-zinc-400">Tu pedido <span class="font-bold text-white">#<c:out value="${pedido.idPedido}"/></span> se ha registrado como pendiente.</p>
        <p class="mt-2 text-lg font-extrabold"><fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/> €</p>
        <a href="${pageContext.request.contextPath}/tienda" class="mt-7 inline-flex rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white">Seguir comprando</a>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>
