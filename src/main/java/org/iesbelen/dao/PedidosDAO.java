package org.iesbelen.dao;

import org.iesbelen.model.Pedidos;

import java.util.List;
import java.util.Optional;

public interface PedidosDAO {

    void create(Pedidos pedidos);
    List<Pedidos> getAll();
    Optional<Pedidos> find(int id);
    void update(Pedidos pedidos);
    void delete(int id);

}
