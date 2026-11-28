package org.iesbelen.dao;

import org.iesbelen.model.CartItem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.List;

public class CheckoutService extends AbstractDAOImpl {

    public int checkout(int userId, List<CartItem> items) {
        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("El carrito está vacío.");
        }

        for (CartItem item : items) {
            if (item.getCantidad() < 1 || !Double.isFinite(item.getPrecio()) || item.getPrecio() < 0) {
                throw new IllegalArgumentException("El carrito contiene un producto no válido.");
            }
        }

        try (Connection connection = connectDB()) {
            connection.setAutoCommit(false);
            try {
                for (CartItem item : items) {
                    validateStock(connection, item);
                }

                int orderId = insertOrder(connection, userId);
                for (CartItem item : items) {
                    insertDetail(connection, orderId, item);
                    decreaseStock(connection, item);
                }
                connection.commit();
                return orderId;
            } catch (Exception e) {
                connection.rollback();
                throw e;
            }
        } catch (Exception e) {
            if (e instanceof IllegalArgumentException) {
                throw (IllegalArgumentException) e;
            }
            throw new DaoException("No se pudo completar la compra; no se han guardado cambios.", e);
        }
    }

    private void validateStock(Connection connection, CartItem item) throws Exception {
        String sql = "SELECT stock FROM productos WHERE id_producto = ? FOR UPDATE";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getIdProducto());
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    throw new IllegalArgumentException("Uno de los productos del carrito ya no existe.");
                }
                if (result.getInt("stock") < item.getCantidad()) {
                    throw new IllegalArgumentException("No hay stock suficiente para " + item.getNombreProducto() + ".");
                }
            }
        }
    }

    private int insertOrder(Connection connection, int userId) throws Exception {
        String sql = "INSERT INTO pedido (id_usuario, fecha, estado) VALUES (?, ?, 'pendiente')";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, userId);
            statement.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new java.sql.SQLException("La base de datos no devolvió el identificador del pedido.");
                }
                return keys.getInt(1);
            }
        }
    }

    private void insertDetail(Connection connection, int orderId, CartItem item) throws Exception {
        String sql = "INSERT INTO detallePedido (id_producto, id_pedido, cantidad, precioUnidad) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getIdProducto());
            statement.setInt(2, orderId);
            statement.setInt(3, item.getCantidad());
            statement.setBigDecimal(4, BigDecimal.valueOf(item.getPrecio()).setScale(2, java.math.RoundingMode.HALF_UP));
            statement.executeUpdate();
        }
    }

    private void decreaseStock(Connection connection, CartItem item) throws Exception {
        String sql = "UPDATE productos SET stock = stock - ? WHERE id_producto = ? AND stock >= ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getCantidad());
            statement.setInt(2, item.getIdProducto());
            statement.setInt(3, item.getCantidad());
            if (statement.executeUpdate() != 1) {
                throw new IllegalArgumentException("El stock de " + item.getNombreProducto() + " ha cambiado. Revisa el carrito.");
            }
        }
    }
}
