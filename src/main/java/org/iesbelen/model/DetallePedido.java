package org.iesbelen.model;

public class DetallePedido {

    private int idDetalle;
    private int idProducto;
    private int idPedido;
    private int cantidad;
    private double precioUd;

    public int getIdDetalle() {return idDetalle;}
    public void setIdDetalle(int idDetalle) {this.idDetalle = idDetalle;}

    public int getIdProducto() {return idProducto;}
    public void setIdProducto(int idProducto) {this.idProducto = idProducto;}

    public int getIdPedido() {return idPedido;}
    public void setIdPedido(int idPedido) {this.idPedido = idPedido;}

    public int getCantidad() {return cantidad;}
    public void setCantidad(int cantidad) {this.cantidad = cantidad;}

    public double getPrecioUd() {return precioUd;}
    public void setPrecioUd(double precioUd) {this.precioUd = precioUd;}

}