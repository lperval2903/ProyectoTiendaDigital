-- ============================================================================
-- Base de datos: proyectoTiendaDigital
-- Motor objetivo: MySQL 8.0+ / MariaDB 10.2+
-- ============================================================================

CREATE DATABASE IF NOT EXISTS proyectoTiendaDigital
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE proyectoTiendaDigital;

-- ----------------------------------------------------------------------------
-- Tabla: categoria
-- Agrupa los productos del catálogo para facilitar búsquedas y filtros.
-- ----------------------------------------------------------------------------
CREATE TABLE categoria (
                           id_categoria    INT AUTO_INCREMENT PRIMARY KEY,
                           nombreCategoria VARCHAR(50) NOT NULL UNIQUE
);

-- ----------------------------------------------------------------------------
-- Tabla: usuario
-- Un usuario puede realizar 1 o varios pedidos (la FK va en la tabla pedido).
-- ----------------------------------------------------------------------------
CREATE TABLE usuario (
                         id_usuario    INT AUTO_INCREMENT PRIMARY KEY,
                         nombreUsuario VARCHAR(20)  NOT NULL UNIQUE,
                         contrasena    VARCHAR(255) NOT NULL,
                         rol           VARCHAR(10) NOT NULL DEFAULT 'cliente'
                             CHECK (rol IN ('cliente', 'admin'))
);

ALTER TABLE usuario
    ADD COLUMN rol VARCHAR(10) NOT NULL DEFAULT 'cliente'
        CHECK (rol IN ('cliente', 'admin'));

-- ----------------------------------------------------------------------------
-- Tabla: productos
-- Catálogo de productos disponibles en la tienda, vinculados a una categoría.
-- ----------------------------------------------------------------------------
CREATE TABLE productos (
                           id_producto    INT AUTO_INCREMENT PRIMARY KEY,
                           id_categoria   INT            NOT NULL,
                           nombreProducto VARCHAR(100)   NOT NULL,
                           stock          INT            NOT NULL DEFAULT 0 CHECK (stock >= 0),
                           precio         DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),

                           CONSTRAINT fk_productos_categoria
                               FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
                                   ON UPDATE CASCADE
                                   ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Tabla: pedido
-- Cada pedido pertenece a un único usuario (1:N desde usuario).
-- ----------------------------------------------------------------------------
CREATE TABLE pedido (
                        id_pedido  INT AUTO_INCREMENT PRIMARY KEY,
                        id_usuario INT         NOT NULL,
                        fecha      DATE        NOT NULL,
                        estado     VARCHAR(10) NOT NULL DEFAULT 'pendiente'
                            CHECK (estado IN ('pendiente', 'enviado', 'entregado')),

                        CONSTRAINT fk_pedido_usuario
                            FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Tabla: detallePedido
-- Resuelve la relación N:M entre pedido y productos.
-- Cada fila representa una línea de producto dentro de un pedido concreto.
-- Se guarda precioUnidad para conservar el precio histórico del momento de compra.
-- ----------------------------------------------------------------------------
CREATE TABLE detallePedido (
                               id_detalle   INT AUTO_INCREMENT PRIMARY KEY,
                               id_pedido    INT            NOT NULL,
                               id_producto  INT            NOT NULL,
                               cantidad     INT            NOT NULL CHECK (cantidad > 0),
                               precioUnidad DECIMAL(10, 2) NOT NULL CHECK (precioUnidad >= 0),

                               CONSTRAINT uq_pedido_producto
                                   UNIQUE (id_pedido, id_producto),

                               CONSTRAINT fk_detalle_pedido
                                   FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
                                       ON UPDATE CASCADE
                                       ON DELETE CASCADE,

                               CONSTRAINT fk_detalle_producto
                                   FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
                                       ON UPDATE CASCADE
                                       ON DELETE RESTRICT
);

-- ============================================================================
-- DATOS: Categorías
-- ============================================================================
INSERT INTO categoria (nombreCategoria) VALUES
                                            ('Ropa y equipación'),
                                            ('Periféricos y setup'),
                                            ('Coleccionismo y accesorios');

-- ============================================================================
-- DATOS: Productos (Merchandising eSports Counter-Strike)
-- ============================================================================
INSERT INTO productos (id_categoria, nombreProducto, stock, precio) VALUES
-- Ropa y equipación
(1, 'Camiseta Pro Jersey 2026 - Edición Local', 45, 69.99),
(1, 'Camiseta Pro Jersey 2026 - Edición Visitante', 38, 69.99),
(1, 'Camiseta Pro Jersey 2026 - Edición Major', 20, 79.99),
(1, 'Camiseta Oversize CS2 "Rush B"', 60, 29.99),
(1, 'Camiseta Oversize "Clutch or Kick"', 55, 29.99),
(1, 'Camiseta Gráfica "One Tap Headshot"', 50, 27.99),
(1, 'Camiseta Minimalista Bombsite A/B', 40, 25.99),
(1, 'Sudadera con Capucha Pro Team 2026', 35, 64.99),
(1, 'Sudadera Oversize "AWP Ace Edition"', 28, 59.99),
(1, 'Sudadera con Cremallera "CT Side Tactical"', 30, 62.50),
(1, 'Chaqueta Cortavientos eSports LAN', 22, 74.99),
(1, 'Chaqueta Bomber Edición Campeones', 15, 89.99),
(1, 'Pantalón Jogger Pro Team Negro', 40, 49.99),
(1, 'Manguito Gaming de Compresión (Arm Sleeve) Pro', 80, 19.99),
(1, 'Gorra Snapback Logo Bordado', 50, 24.99),
(1, 'Gorro Beanie "Frosty Aim"', 42, 18.99),
(1, 'Calcetines Altos eSports Pack x2', 90, 14.99),
-- Periféricos y setup
(2, 'Alfombrilla Gaming XL Control - Mirage Edition', 35, 34.99),
(2, 'Alfombrilla Gaming XL Speed - Inferno Edition', 30, 34.99),
(2, 'Alfombrilla Deskmat XXL - Radar Callouts', 25, 39.99),
(2, 'Set de Keycaps PBT Tema CS2 (WASD + Flechas)', 48, 22.99),
(2, 'Keycap Artesanal Resina - Bomba C4', 18, 29.50),
(2, 'Keycap Artesanal Resina - Cuchillo Karambit', 14, 32.00),
(2, 'Reposamuñecas Ergonómico Pro Team', 32, 21.99),
(2, 'Mouse Bungee Antideslizante Edición Pro', 26, 19.50),
(2, 'Grips Antideslizantes para Ratón CS Edition', 75, 11.99),
-- Coleccionismo y accesorios
(3, 'Pin Metálico Coleccionable - Global Elite', 65, 9.99),
(3, 'Pin Metálico Coleccionable - Defuse Kit', 70, 9.99),
(3, 'Pin Metálico Coleccionable - Flashbang', 60, 9.99),
(3, 'Lanyard / Cinta Acreditación LAN Pro', 100, 7.99),
(3, 'Llavero Metálico Karambit Fade (Réplica Mini)', 55, 12.99),
(3, 'Llavero Metálico AWP Asiimov (Réplica Mini)', 48, 12.99),
(3, 'Botella Térmica Acero Inoxidable 750ml Pro Team', 40, 24.99),
(3, 'Taza Cerámica "Eco Round Coffee"', 50, 13.99),
(3, 'Mochila Gaming LAN para Portátil y Periféricos', 18, 79.99),
(3, 'Bandera de Pared 150x90cm Pro Team', 35, 19.99),
(3, 'Póster Metálico A3 - Mapa Dust II Vintage', 24, 34.99),
(3, 'Pack de 15 Pegatinas Holográficas CS eSports', 120, 8.99),
(3, 'Figura Chibi Coleccionable - Operador SAS', 20, 26.99),
(3, 'Figura Chibi Coleccionable - Agente Phoenix', 19, 26.99);