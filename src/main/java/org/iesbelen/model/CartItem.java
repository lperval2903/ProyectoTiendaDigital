package org.iesbelen.model;

import java.io.Serializable;

public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private int idProducto;
    private String nombreProducto;
    private double precio;
    private int cantidad;

    public CartItem() {
    }

    public CartItem(Producto producto, int cantidad) {
        this.idProducto = producto.getIdProducto();
        this.nombreProducto = producto.getNombreProducto();
        this.precio = producto.getPrecio();
        this.cantidad = cantidad;
    }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombreProducto) { this.nombreProducto = nombreProducto; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public double getSubtotal() {
        return java.math.BigDecimal.valueOf(precio)
                .multiply(java.math.BigDecimal.valueOf(cantidad))
                .setScale(2, java.math.RoundingMode.HALF_UP)
                .doubleValue();
    }
}
