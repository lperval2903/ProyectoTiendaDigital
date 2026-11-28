# Xend Shop

Aplicación web Java con JSP, JSTL, Servlets y JDBC para Tomcat 10.1/11 y MySQL 8.

## Preparar MySQL

1. Ejecuta `src/main/resources/db/schema.sql` en MySQL. Crea el esquema `proyectotiendadigital`, las tablas y datos de ejemplo.
2. Comprueba los datos de conexión en `src/main/java/org/iesbelen/dao/database.properties` y configura ahí usuario y contraseña de MySQL.
3. Las cuentas iniciales son `admin / 12345678` y `usuario / usuario`. Las contraseñas se guardan con SHA-256.

## Construir y desplegar

Necesitas JDK 17 o superior y Tomcat 10.1 o 11. Desde la raíz:

```powershell
.\mvnw.cmd clean package
```

Copia `target/proyectoTiendaDigital-1.0-SNAPSHOT.war` a `TOMCAT_HOME\webapps`. Inicia Tomcat y abre `http://localhost:8080/proyectoTiendaDigital-1.0-SNAPSHOT/`. Para usar una URL más corta, renombra el WAR a `xend-shop.war` y visita `http://localhost:8080/xend-shop/`.

## Funcionalidades

- Catálogo público, búsqueda y filtros por categoría.
- Carrito guardado en la sesión; para finalizar la compra es necesario iniciar sesión.
- Registro e inicio/cierre de sesión.
- Pedidos con detalles y actualización de inventario dentro de una transacción.
- CRUD de administración protegido por rol, en las rutas `/admin/*`.

Tailwind CSS y las fuentes de Google se cargan desde CDN, por lo que su presentación necesita conexión a Internet.
