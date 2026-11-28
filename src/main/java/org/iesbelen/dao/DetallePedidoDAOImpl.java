package org.iesbelen.dao;

import org.iesbelen.model.DetallePedido;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class DetallePedidoDAOImpl extends AbstractDAOImpl implements DetallePedidoDAO {

    @Override
    public void create(DetallePedido detalle) {
        String sql = "INSERT INTO detallePedido (id_producto, id_pedido, cantidad, precioUnidad) VALUES (?, ?, ?, ?)";
        try (Connection connection = connectDB()) {
            connection.setAutoCommit(false);
            try {
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    bind(statement, detalle);
                    statement.executeUpdate();
                }
                connection.commit();
            } catch (Exception e) {
                connection.rollback();
                throw e;
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo crear el detalle del pedido.", e);
        }
    }

    @Override
    public List<DetallePedido> getAll() {
        List<DetallePedido> detalles = new ArrayList<DetallePedido>();
        String sql = "SELECT id_detalle, id_producto, id_pedido, cantidad, precioUnidad FROM detallePedido ORDER BY id_pedido DESC, id_detalle";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                detalles.add(map(result));
            }
            return detalles;
        } catch (Exception e) {
            throw new DaoException("No se pudieron consultar los detalles de pedido.", e);
        }
    }

    @Override
    public Optional<DetallePedido> find(int id) {
        String sql = "SELECT id_detalle, id_producto, id_pedido, cantidad, precioUnidad FROM detallePedido WHERE id_detalle = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(map(result)) : Optional.<DetallePedido>empty();
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo consultar el detalle del pedido.", e);
        }
    }

    @Override
    public void update(DetallePedido detalle) {
        String sql = "UPDATE detallePedido SET id_producto = ?, id_pedido = ?, cantidad = ?, precioUnidad = ? WHERE id_detalle = ?";
        try (Connection connection = connectDB()) {
            connection.setAutoCommit(false);
            try {
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    bind(statement, detalle);
                    statement.setInt(5, detalle.getIdDetalle());
                    statement.executeUpdate();
                }
                connection.commit();
            } catch (Exception e) {
                connection.rollback();
                throw e;
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo actualizar el detalle del pedido.", e);
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM detallePedido WHERE id_detalle = ?";
        try (Connection connection = connectDB()) {
            connection.setAutoCommit(false);
            try {
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setInt(1, id);
                    statement.executeUpdate();
                }
                connection.commit();
            } catch (Exception e) {
                connection.rollback();
                throw e;
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo eliminar el detalle del pedido.", e);
        }
    }

    private void bind(PreparedStatement statement, DetallePedido detalle) throws java.sql.SQLException {
        statement.setInt(1, detalle.getIdProducto());
        statement.setInt(2, detalle.getIdPedido());
        statement.setInt(3, detalle.getCantidad());
        statement.setDouble(4, detalle.getPrecioUd());
    }

    private DetallePedido map(ResultSet result) throws java.sql.SQLException {
        DetallePedido detalle = new DetallePedido();
        detalle.setIdDetalle(result.getInt("id_detalle"));
        detalle.setIdProducto(result.getInt("id_producto"));
        detalle.setIdPedido(result.getInt("id_pedido"));
        detalle.setCantidad(result.getInt("cantidad"));
        detalle.setPrecioUd(result.getDouble("precioUnidad"));
        return detalle;
    }
}
