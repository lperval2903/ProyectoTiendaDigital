package org.iesbelen.model;

import java.time.LocalDateTime;

public class Pedidos {

    private int idPedido;
    private int idUsuario;
    private java.time.LocalDateTime fecha;
    private String estado;
    private double total;

    public int getIdPedido() {return idPedido;}

    public void setIdPedido(int idPedido) {this.idPedido = idPedido;}

    public int getIdUsuario() {return idUsuario;}

    public void setIdUsuario(int idUsuario) {this.idUsuario = idUsuario;}

    public LocalDateTime getFecha() {return fecha;}

    public void setFecha(LocalDateTime fecha) {this.fecha = fecha;}

    public String getEstado() {return estado;}

    public void setEstado(String estado) {this.estado = estado;}

    public double getTotal() {return total;}

    public void setTotal(double total) {this.total = total;}
}