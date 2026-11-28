package org.iesbelen.dao;

import org.iesbelen.model.Categorias;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CategoriasDAOImpl extends AbstractDAOImpl implements CategoriasDAO {

    @Override
    public void create(Categorias categoria) {
        String sql = "INSERT INTO categoria (nombreCategoria) VALUES (?)";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, categoria.getNombreCategoria());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo crear la categoría.", e);
        }
    }

    @Override
    public List<Categorias> getAll() {
        List<Categorias> categorias = new ArrayList<Categorias>();
        String sql = "SELECT id_categoria, nombreCategoria FROM categoria ORDER BY nombreCategoria";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Categorias categoria = new Categorias();
                categoria.setIdCategoria(result.getInt("id_categoria"));
                categoria.setNombreCategoria(result.getString("nombreCategoria"));
                categorias.add(categoria);
            }
            return categorias;
        } catch (Exception e) {
            throw new DaoException("No se pudieron consultar las categorías.", e);
        }
    }

    @Override
    public Optional<Categorias> find(int id) {
        String sql = "SELECT id_categoria, nombreCategoria FROM categoria WHERE id_categoria = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    return Optional.empty();
                }
                Categorias categoria = new Categorias();
                categoria.setIdCategoria(result.getInt("id_categoria"));
                categoria.setNombreCategoria(result.getString("nombreCategoria"));
                return Optional.of(categoria);
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo consultar la categoría.", e);
        }
    }

    @Override
    public void update(Categorias categoria) {
        String sql = "UPDATE categoria SET nombreCategoria = ? WHERE id_categoria = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, categoria.getNombreCategoria());
            statement.setInt(2, categoria.getIdCategoria());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo actualizar la categoría.", e);
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM categoria WHERE id_categoria = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo eliminar la categoría.", e);
        }
    }
}
