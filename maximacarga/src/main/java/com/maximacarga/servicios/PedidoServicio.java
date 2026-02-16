package com.maximacarga.servicios;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.maximacarga.dtos.PedidoDto;
import com.maximacarga.dtos.UsuarioDto;

/**
 * Servicio web encargado de comunicarse con la API de pedidos.
 * Permite:
 * - Comprar
 * - Listar pedidos
 * - Cambiar estado
 * - Obtener por ID
 * - Eliminar pedidos
 */
@Service
public class PedidoServicio {

    private final RestTemplate restTemplate = new RestTemplate();
    
    private String apiUrl = "http://localhost:8083/api";


    /**
     * Realiza la compra enviando el carrito a la API.
     */
    public void comprar(Long idUsuario, Map<Long, Integer> carrito) {
        String url = "http://localhost:8083/api/pedidos/" + idUsuario;

        Map<String, Integer> carritoApi = carrito.entrySet().stream()
                .collect(java.util.stream.Collectors.toMap(
                        e -> String.valueOf(e.getKey()),
                        Map.Entry::getValue
                ));

        restTemplate.postForObject(url, carritoApi, Void.class);
    }
    
    private final String API_URL = "http://localhost:8083/api/pedidos";

   
    @Autowired
    private UsuarioServicio usuarioServicio;
    
    /**
     * Lista todos los pedidos y añade el nombre del usuario
     * asociado a cada pedido.
     */
    public List<PedidoDto> listarTodos() {

        PedidoDto[] pedidosArray = restTemplate.getForObject(API_URL, PedidoDto[].class);
        List<PedidoDto> pedidos = pedidosArray == null ? List.of() : Arrays.asList(pedidosArray);

        for (PedidoDto pedido : pedidos) {

            System.out.println("Pedido ID: " + pedido.getId());
            System.out.println("UsuarioId del pedido: " + pedido.getUsuarioId());

            try {
                if (pedido.getUsuarioId() != null) {

                    UsuarioDto usuario = usuarioServicio.obtenerUsuarioPorId(pedido.getUsuarioId());

                    if (usuario != null) {
                        System.out.println("Usuario encontrado: " + usuario.getNombreUsuario());
                        pedido.setNombreUsuario(usuario.getNombreUsuario());
                    } else {
                        System.out.println("⚠️ Usuario es NULL");
                    }

                } else {
                    System.out.println("⚠️ El pedido tiene usuarioId NULL");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        return pedidos;
    }
    

    /**
     * Cambia el estado de un pedido.
     */
    public boolean cambiarEstadoPedido(Long idPedido, String estado) throws Exception {

        System.out.println("➡️ Entrando a cambiarEstadoPedido");

        String url = "http://localhost:8083/api/pedidos/" + idPedido + "/estado"
                + "?estado=" + URLEncoder.encode(estado, StandardCharsets.UTF_8);

        System.out.println("🔗 URL cambio estado pedido: " + url);

        HttpClient client = HttpClient.newBuilder().build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(url))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.noBody())
                .build();

        HttpResponse<String> response = client.send(
                request,
                HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8)
        );

        int status = response.statusCode();
        String body = response.body();

        System.out.println("📡 Código respuesta cambio estado: " + status);
        System.out.println("📩 Respuesta API: " + body);

        if (status == 200) {
            System.out.println("✅ Estado del pedido actualizado correctamente");
            return true;
        } else if (status == 400) {
            System.out.println("⚠️ Estado inválido o transición no permitida");
            return false;
        } else if (status == 404) {
            System.out.println("❌ Pedido no encontrado");
            return false;
        } else {
            System.out.println("❌ Error inesperado al cambiar estado");
            return false;
        }
    }
    

    /**
     * Lista los pedidos de un usuario específico.
     */
    public List<PedidoDto> listarPorUsuario(Long idUsuario) throws IOException, URISyntaxException {

        URI uri = new URI("http://localhost:8083/api/pedidos/usuario/" + idUsuario);
        URL url = uri.toURL();

        HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
        conexion.setRequestMethod("GET");
        conexion.setRequestProperty("Accept", "application/json");

        int codigoRespuesta = conexion.getResponseCode();

        if (codigoRespuesta == HttpURLConnection.HTTP_OK) {

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(conexion.getInputStream())
            );

            StringBuilder response = new StringBuilder();
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            ObjectMapper mapper = new ObjectMapper();
            mapper.registerModule(new JavaTimeModule());

            return mapper.readValue(
                    response.toString(),
                    new TypeReference<List<PedidoDto>>() {}
            );
        }

        return List.of();
    }
    
    
    /**
     * Obtiene un pedido por su ID.
     */
    public PedidoDto obtenerPorId(Long id) {

        String url = apiUrl + "/pedidos/" + id;

        return restTemplate.getForObject(url, PedidoDto.class);
    }
    

    /**
     * Actualiza el estado de un pedido.
     */
    public void actualizarPedido(Long id, PedidoDto pedido) {

        if (pedido.getEstado() == null || pedido.getEstado().isBlank()) {
            throw new RuntimeException("El estado no puede ser null o vacío");
        }

        String url = apiUrl + "/pedidos/" + id + "/estado?estado=" 
                     + pedido.getEstado();

        restTemplate.put(url, null);
    }
    
    /**
     * Elimina un pedido por su ID.
     */
    public void eliminarPedido(Long id) {

        String url = apiUrl + "/pedidos/" + id;

        restTemplate.delete(url);
    }

}
