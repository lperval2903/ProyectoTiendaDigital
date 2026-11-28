package org.iesbelen.dao;

import org.iesbelen.model.Usuario;
import org.iesbelen.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UsuarioDAOImpl extends AbstractDAOImpl implements UsuarioDAO {

    @Override
    public void create(Usuario usuario) {
        String sql = "INSERT INTO usuario (nombreUsuario, contrasena, rol) VALUES (?, ?, ?)";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getContrasena());
            statement.setString(3, usuario.getRol());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo crear el usuario.", e);
        }
    }

    @Override
    public List<Usuario> getAll() {
        List<Usuario> usuarios = new ArrayList<Usuario>();
        String sql = "SELECT id_usuario, nombreUsuario, rol FROM usuario ORDER BY nombreUsuario";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(result.getInt("id_usuario"));
                usuario.setNombre(result.getString("nombreUsuario"));
                usuario.setRol(result.getString("rol"));
                usuarios.add(usuario);
            }
            return usuarios;
        } catch (Exception e) {
            throw new DaoException("No se pudieron consultar los usuarios.", e);
        }
    }

    @Override
    public Optional<Usuario> find(int id) {
        String sql = "SELECT id_usuario, nombreUsuario, rol FROM usuario WHERE id_usuario = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    return Optional.empty();
                }
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(result.getInt("id_usuario"));
                usuario.setNombre(result.getString("nombreUsuario"));
                usuario.setRol(result.getString("rol"));
                return Optional.of(usuario);
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo consultar el usuario.", e);
        }
    }

    @Override
    public Optional<Usuario> authenticate(String username, String password) {
        String sql = "SELECT id_usuario, nombreUsuario, contrasena, rol FROM usuario WHERE nombreUsuario = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next() || !PasswordUtil.matches(password, result.getString("contrasena"))) {
                    return Optional.empty();
                }
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(result.getInt("id_usuario"));
                usuario.setNombre(result.getString("nombreUsuario"));
                usuario.setRol(result.getString("rol"));
                return Optional.of(usuario);
            }
        } catch (Exception e) {
            throw new DaoException("No se pudo autenticar al usuario.", e);
        }
    }

    @Override
    public void update(Usuario usuario) {
        String sql = "UPDATE usuario SET nombreUsuario = ?, rol = ? WHERE id_usuario = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getRol());
            statement.setInt(3, usuario.getIdUsuario());
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo actualizar el usuario.", e);
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";
        try (Connection connection = connectDB();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            throw new DaoException("No se pudo eliminar el usuario.", e);
        }
    }
}
