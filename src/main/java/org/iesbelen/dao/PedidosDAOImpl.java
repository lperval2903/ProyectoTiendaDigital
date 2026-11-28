package org.iesbelen.dao;

import org.iesbelen.model.Pedidos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PedidosDAOImpl extends AbstractDAOImpl implements PedidosDAO {

    @Override
    public void create(Pedidos pedido) {
        String sql = "INSERT INTO pedido (id_usuario, fecha, estado) VALUES (?, ?, ?)";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, pedido.getIdUsuario());
            statement.setDate(2, java.sql.Date.valueOf(pedido.getFecha().toLocalDate()));
            statement.setString(3, pedido.getEstado());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo crear el pedido.", e);
        }
    }

    @Override
    public List<Pedidos> getAll() {
        List<Pedidos> pedidos = new ArrayList<Pedidos>();
        String sql = "SELECT p.id_pedido, p.id_usuario, p.fecha, p.estado, "
                + "(SELECT COALESCE(SUM(d.cantidad * d.precioUnidad), 0) "
                + "FROM detallePedido d WHERE d.id_pedido = p.id_pedido) AS total "
                + "FROM pedido p ORDER BY p.fecha DESC";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                pedidos.add(map(result));
            }
            return pedidos;
        } catch (Exception e) {
            throw new DaoException("No se pudieron consultar los pedidos.", e);
        }
    }

    @Override
    public Optional<Pedidos> find(int id) {
        String sql = "SELECT p.id_pedido, p.id_usuario, p.fecha, p.estado, "
                + "(SELECT COALESCE(SUM(d.cantidad * d.precioUnidad), 0) "
                + "FROM detallePedido d WHERE d.id_pedido = p.id_pedido) AS total "
                + "FROM pedido p WHERE p.id_pedido = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(map(result)) : Optional.<Pedidos>empty();
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo consultar el pedido.", e);
        }
    }

    @Override
    public void update(Pedidos pedido) {
        String sql = "UPDATE pedido SET estado = ? WHERE id_pedido = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, pedido.getEstado());
            statement.setInt(2, pedido.getIdPedido());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo actualizar el pedido.", e);
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM pedido WHERE id_pedido = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo eliminar el pedido.", e);
        }
    }

    private Pedidos map(ResultSet result) throws java.sql.SQLException {
        Pedidos pedido = new Pedidos();
        pedido.setIdPedido(result.getInt("id_pedido"));
        pedido.setIdUsuario(result.getInt("id_usuario"));
        pedido.setFecha(result.getDate("fecha").toLocalDate().atStartOfDay());
        pedido.setEstado(result.getString("estado"));
        pedido.setTotal(result.getDouble("total"));
        return pedido;
    }
}
