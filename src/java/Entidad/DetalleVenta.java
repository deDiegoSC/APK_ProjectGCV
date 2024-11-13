/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author DIEGO
 */
public class DetalleVenta {
    int idSaleDetail;
    int idSale;
    int idProduct;
    int amount;
    double price;
    double discount;
    String productName;

    public DetalleVenta(int idSaleDetail, int idSale, int idProduct, int amount, double price, double discount, String productName) {
        this.idSaleDetail = idSaleDetail;
        this.idSale = idSale;
        this.idProduct = idProduct;
        this.amount = amount;
        this.price = price;
        this.discount = discount;
        this.productName = productName;
    }



    public DetalleVenta() {
    }

    public int getIdSaleDetail() {
        return idSaleDetail;
    }

    public void setIdSaleDetail(int idSaleDetail) {
        this.idSaleDetail = idSaleDetail;
    }

    public int getIdSale() {
        return idSale;
    }

    public void setIdSale(int idSale) {
        this.idSale = idSale;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    public double getSubtotal() {
        return (amount * price) - discount;
    }
    
}
