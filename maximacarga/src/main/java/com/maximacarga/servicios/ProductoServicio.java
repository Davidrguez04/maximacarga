package com.maximacarga.servicios;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.maximacarga.dtos.ProductoDto;

/**
 * Servicio web encargado de comunicarse con la API de productos.
 * Permite crear, listar, eliminar, obtener y actualizar productos.
 */
@Service
public class ProductoServicio {

	 /**
     * Envía un nuevo producto a la API para su creación.
     * Incluye imagen si se proporciona.
     */
		public String guardarProducto(String nombre,
	            String descripcion,
	            Double precio,
	            Integer stock,
	            MultipartFile imagen) throws IOException, URISyntaxException {
	
		// 1. Montamos el DTO
		ProductoDto dto = new ProductoDto();
		dto.setNombre(nombre);
		dto.setDescripcion(descripcion);
		dto.setPrecio(precio);
		dto.setStock(stock);
		
		// ⬇️ NUEVO: meter la imagen en el DTO si viene algo
		if (imagen != null && !imagen.isEmpty()) {
		dto.setImagenProducto(imagen.getBytes());
		}
		
		// 2. Serializamos a JSON
		ObjectMapper mapper = new ObjectMapper();
		mapper.registerModule(new JavaTimeModule());
		mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
		mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		
		String json = mapper.writeValueAsString(dto);
		
		// 3. Llamamos a la API REST
		URI uri = new URI("http://localhost:8083/api/productos");
		URL url = uri.toURL();
		
		HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
		conexion.setRequestMethod("POST");
		conexion.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conexion.setDoOutput(true);
		
		try (OutputStream os = conexion.getOutputStream()) {
		byte[] input = json.getBytes(StandardCharsets.UTF_8);
		os.write(input, 0, input.length);
		}
		
		int codigoRespuesta = conexion.getResponseCode();
		System.out.println(">>> [WEB] Código respuesta crear producto: " + codigoRespuesta);
		
		if (codigoRespuesta >= 200 && codigoRespuesta < 300) {
			return "success";
			} else {
			try (BufferedReader br = new BufferedReader(
			new InputStreamReader(conexion.getErrorStream(), StandardCharsets.UTF_8))) {
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
		sb.append(line);
		}
		System.out.println(">>> [WEB] Error API crear producto: " + sb);
		}
			return "error";
		}
	}
		

	    /**
	     * Obtiene todos los productos desde la API.
	     * Convierte imágenes en Base64 para mostrarlas en las vistas.
	     */
		public java.util.List<ProductoDto> obtenerTodos() throws IOException, URISyntaxException {
	        URI uri = new URI("http://localhost:8083/api/productos");
	        URL url = uri.toURL();

	        HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
	        conexion.setRequestMethod("GET");
	        conexion.setRequestProperty("Accept", "application/json");

	        int codigoRespuesta = conexion.getResponseCode();
	        if (codigoRespuesta < 200 || codigoRespuesta >= 300) {
	            return java.util.Collections.emptyList();
	        }

	        try (BufferedReader br = new BufferedReader(
	                new InputStreamReader(conexion.getInputStream(), StandardCharsets.UTF_8))) {

	            StringBuilder sb = new StringBuilder();
	            String line;
	            while ((line = br.readLine()) != null) {
	                sb.append(line);
	            }

	            String json = sb.toString();

	            ObjectMapper mapper = new ObjectMapper();
	            mapper.registerModule(new JavaTimeModule());
	            mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	            mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

	            ProductoDto[] array = mapper.readValue(json, ProductoDto[].class);
	            java.util.List<ProductoDto> lista = java.util.Arrays.asList(array);

	            // ⬇️ NUEVO: pasar byte[] -> Base64 para las vistas
	            java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
	            for (ProductoDto p : lista) {
	                if (p.getImagenProducto() != null && p.getImagenProducto().length > 0) {
	                    String base64 = encoder.encodeToString(p.getImagenProducto());
	                    p.setImagenBase64(base64);
	                }
	            }

	            return lista;
	        }
	    }

		 /**
	     * Elimina un producto por su ID.
	     */
    public String eliminarProducto(Long idProducto) throws IOException, URISyntaxException {
        URI uri = new URI("http://localhost:8083/api/productos/" + idProducto);
        HttpURLConnection conexion = (HttpURLConnection) uri.toURL().openConnection();
        conexion.setRequestMethod("DELETE");

        int codigoRespuesta = conexion.getResponseCode();
        System.out.println(">>> [WEB] Código respuesta DELETE producto " + idProducto + ": " + codigoRespuesta);

        if (codigoRespuesta >= 200 && codigoRespuesta < 300) {
            return "success";
        } else {
            return "error";
        }
    }
    
    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * Obtiene un producto por su ID.
     */
    public ProductoDto obtenerProductoPorId(Long id) {

        String url = "http://localhost:8083/api/productos/" + id;

        return restTemplate.getForObject(url, ProductoDto.class);
    }

    private String apiUrl = "http://localhost:8083/api";
    /**
     * Actualiza un producto existente.
     */
    public void actualizarProducto(ProductoDto producto) {

        String url = apiUrl + "/productos/" + producto.getIdProducto();

        restTemplate.put(url, producto);
    }
    
}
