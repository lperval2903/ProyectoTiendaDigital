package org.iesbelen.dao;

import org.iesbelen.model.DetallePedido;

import java.util.List;
import java.util.Optional;

public interface DetallePedidoDAO {

    void create(DetallePedido detallePedido);
    List<DetallePedido> getAll();
    Optional<DetallePedido> find(int id);
    void update(DetallePedido detallePedido);
    void delete(int id);

}
