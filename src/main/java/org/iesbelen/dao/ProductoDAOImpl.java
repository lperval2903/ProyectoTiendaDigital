package org.iesbelen.dao;

import org.iesbelen.model.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductoDAOImpl extends AbstractDAOImpl implements ProductoDAO {

    @Override
    public void create(Producto producto) {
        String sql = "INSERT INTO productos (id_categoria, nombre_producto, stock, precio) VALUES (?, ?, ?, ?)";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bind(statement, producto);
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo crear el producto.", e);
        }
    }

    @Override
    public List<Producto> getAll() {
        List<Producto> productos = new ArrayList<Producto>();
        String sql = "SELECT id_producto, id_categoria, nombre_producto, stock, precio FROM productos ORDER BY nombre_producto";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                productos.add(map(result));
            }
            return productos;
        } catch (Exception e) {
            throw new DaoException("No se pudieron consultar los productos.", e);
        }
    }

    @Override
    public Optional<Producto> find(int id) {
        String sql = "SELECT id_producto, id_categoria, nombre_producto, stock, precio FROM productos WHERE id_producto = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(map(result)) : Optional.<Producto>empty();
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo consultar el producto.", e);
        }
    }

    @Override
    public void update(Producto producto) {
        String sql = "UPDATE productos SET id_categoria = ?, nombre_producto = ?, stock = ?, precio = ? WHERE id_producto = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bind(statement, producto);
            statement.setInt(5, producto.getIdProducto());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo actualizar el producto.", e);
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM productos WHERE id_producto = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo eliminar el producto.", e);
        }
    }

    private void bind(PreparedStatement statement, Producto producto) throws java.sql.SQLException {
        statement.setInt(1, producto.getIdCategoria());
        statement.setString(2, producto.getNombreProducto());
        statement.setInt(3, producto.getStock());
        statement.setDouble(4, producto.getPrecio());
    }

    private Producto map(ResultSet result) throws java.sql.SQLException {
        Producto producto = new Producto();
        producto.setIdProducto(result.getInt("id_producto"));
        producto.setIdCategoria(result.getInt("id_categoria"));
        producto.setNombreProducto(result.getString("nombre_producto"));
        producto.setStock(result.getInt("stock"));
        producto.setPrecio(result.getDouble("precio"));
        return producto;
    }
}
