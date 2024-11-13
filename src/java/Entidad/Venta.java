/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

import java.util.Date;
import java.util.List;

/**
 *
 * @author DIEGO
 */
public class Venta {

    int idSale;
    int idClient;
    double totalPrice;
    Date date;
    List<DetalleVenta> detalles;

    public Venta() {
    }

    public Venta(int idSale, int idClient, double totalPrice, Date date, List<DetalleVenta> detalles) {
        this.idSale = idSale;
        this.idClient = idClient;
        this.totalPrice = totalPrice;
        this.date = date;
        this.detalles = detalles;
    }



    public int getIdSale() {
        return idSale;
    }

    public void setIdSale(int idSale) {
        this.idSale = idSale;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    public List<DetalleVenta> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleVenta> detalles) {
        this.detalles = detalles;
    }

}
