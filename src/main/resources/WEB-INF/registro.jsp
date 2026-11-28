<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Crear cuenta | Xend Shop</title>
    <%@ include file="/WEB-INF/fragmentos/head.jsp" %>
</head>
<body class="min-h-screen bg-ink text-white antialiased">
<jsp:include page="/WEB-INF/fragmentos/header.jsp" />
<main class="mx-auto max-w-md px-5 py-14">
    <section class="rounded-xl border border-white/10 bg-panel p-6 sm:p-8">
        <p class="text-xs font-bold uppercase tracking-[.2em] text-acid">Únete a Xend</p>
        <h1 class="display-font mt-2 text-5xl font-bold uppercase">Crear cuenta</h1>
        <c:if test="${not empty error}">
            <p role="alert" class="mt-5 rounded-lg border border-red-400/20 bg-red-400/5 px-4 py-3 text-sm text-red-200"><c:out value="${error}"/></p>
        </c:if>
        <form action="${pageContext.request.contextPath}/usuarios/registro" method="post" class="mt-6 space-y-4">
            <div>
                <label for="nombre" class="mb-2 block text-sm font-semibold">Usuario</label>
                <input id="nombre" name="nombre" required maxlength="50" autocomplete="username"
                       class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
            </div>
            <div>
                <label for="contrasena" class="mb-2 block text-sm font-semibold">Contraseña</label>
                <input id="contrasena" name="contrasena" type="password" required minlength="4" autocomplete="new-password"
                       class="w-full rounded-lg border border-white/10 bg-ink px-4 py-3 text-sm outline-none focus:border-acid">
                <p class="mt-2 text-xs text-zinc-500">Mínimo 4 caracteres.</p>
            </div>
            <button class="w-full rounded-lg bg-acid px-5 py-3 text-sm font-extrabold text-ink transition hover:bg-white" type="submit">Crear cuenta</button>
        </form>
        <p class="mt-5 text-center text-sm text-zinc-400">¿Ya tienes cuenta?
            <a class="font-bold text-acid hover:text-white" href="${pageContext.request.contextPath}/usuarios/login">Inicia sesión</a>
        </p>
    </section>
</main>
<jsp:include page="/WEB-INF/fragmentos/footer.jsp" />
</body>
</html>
