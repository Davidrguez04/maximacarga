package com.maximacarga.dtos;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ProductoDto {

	//Atributos
	
	
	   private Long idProducto;
	   private String nombre;
	    private String descripcion;
	    private Double precio;
	    private Integer stock;
	    private byte[] imagenProducto;      
		private String imagenBase64;
	   
		

	    //Getterts y setters
	 
	public Long getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(Long idProducto) {
		this.idProducto = idProducto;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public Double getPrecio() {
		return precio;
	}
	public void setPrecio(Double precio) {
		this.precio = precio;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	
	 public byte[] getImagenProducto() {
			return imagenProducto;
		}
		public void setImagenProducto(byte[] imagenProducto) {
			this.imagenProducto = imagenProducto;
		}
		public String getImagenBase64() {
			return imagenBase64;
		}
		public void setImagenBase64(String imagenBase64) {
			this.imagenBase64 = imagenBase64;
		}
		
}
