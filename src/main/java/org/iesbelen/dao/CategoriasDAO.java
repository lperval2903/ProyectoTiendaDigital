package org.iesbelen.dao;

import org.iesbelen.model.Categorias;

import java.util.List;
import java.util.Optional;

public interface CategoriasDAO {

    void create(Categorias categoria);
    List<Categorias> getAll();
    Optional<Categorias> find(int id);
    void update(Categorias categoria);
    void delete(int id);

}
