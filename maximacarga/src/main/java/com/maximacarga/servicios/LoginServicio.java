package com.maximacarga.servicios;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.maximacarga.dtos.UsuarioDto;

import jakarta.servlet.http.HttpSession;

/**
 * Servicio encargado de la autenticación en la parte web.
 * Se comunica con la API para:
 * - Realizar login
 * - Obtener token JWT
 * - Obtener datos completos del usuario
 * - Restablecer contraseña
 */
@Service
public class LoginServicio {

	@Autowired 
    UsuarioServicio usuarioServicio;
	
	   /**
     * Inicia sesión del usuario.
     * - Envía credenciales a la API.
     * - Obtiene token JWT.
     * - Recupera datos completos del usuario.
     * - Guarda token y usuario en sesión.
     */
	public String iniciarSesion(String email, String contrasenia, HttpSession sesion) throws URISyntaxException, IOException {
        UsuarioDto usuarioLogin = new UsuarioDto();
        usuarioLogin.setCorreoElectronico(email);
        usuarioLogin.setContrasena(contrasenia);
        
        // Enviar los datos a la API para autenticación y obtener el token
        String token = enviarLoginUsuario(usuarioLogin);

        if (token != null) {
            System.out.println("¡Inicio de sesión exitoso!");
            sesion.setAttribute("token", token);
            
            // Obtener los detalles del usuario, incluyendo su rol
            UsuarioDto usuarioCompleto = usuarioServicio.obtenerDetallesUsuario(email, token);
            System.out.println("ID DEL USUARIO LOGIN: " + usuarioCompleto.getIdUsuario());
            
            if (usuarioCompleto != null) {
                System.out.println("Usuario autenticado: " + usuarioCompleto.getNombreUsuario() + " - Rol: " + usuarioCompleto.getTipoUsuario());
                
                // Guardar los detalles en la sesión
                sesion.setAttribute("usuario", usuarioCompleto);
                
                return "success"; // Indica que el login fue correcto
            } else {
                System.out.println("[ERROR] No se pudieron obtener los detalles del usuario.");
                return "error";
            }
        } else {
            System.out.println("[ERROR] Credenciales incorrectas o fallo en la API.");
            return "error";
        }
    }
	
	/**
     * Envía las credenciales a la API para autenticación.
     * Devuelve el token JWT si la autenticación es correcta.
     */
	public String enviarLoginUsuario(UsuarioDto usuario) throws URISyntaxException, IOException {
        URI uri = new URI("http://localhost:8083/api/usuarios/login");
        URL url = uri.toURL();

        HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
        conexion.setRequestMethod("POST");
        conexion.setRequestProperty("Content-Type", "application/json");
        conexion.setDoOutput(true);

        // Convertir el objeto usuario a JSON para enviarlo a la API
        ObjectMapper mapper = new ObjectMapper();
        String usuarioJson = mapper.writeValueAsString(usuario);
        System.out.println("Enviando JSON al backend: " + usuarioJson);
        // Enviar los datos al servidor
        OutputStream os = conexion.getOutputStream();
        os.write(usuarioJson.getBytes());
        os.flush();

        // Leer la respuesta del servidor
        int codigoRespuesta = conexion.getResponseCode();
        System.out.println("Código de respuesta: " + codigoRespuesta);

        if (codigoRespuesta == HttpURLConnection.HTTP_OK) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            System.out.println("Respuesta de la API: " + response.toString());
            // Extraer el token de la respuesta
            Map<String, Object> responseMap = mapper.readValue(response.toString(), Map.class);
            if (responseMap.containsKey("token")) {
                return (String) responseMap.get("token");
            }
        }

        return null; // Si la API no devuelve un token o hay un error
    }
	
	   /**
     * Restablece la contraseniaa enviando token y nueva contraseniaa a la API.
     */
	public boolean restablecerContrasenia(String token, String nuevaContrasenia)
	        throws IOException, URISyntaxException {

	    Map<String, String> payload = new HashMap<>();
	    payload.put("tokenRecuperacion", token);
	    payload.put("nuevaContrasenia", nuevaContrasenia);

	    ObjectMapper mapper = new ObjectMapper();
	    String usuarioJson = mapper.writeValueAsString(payload);

	    URI uri = new URI("http://localhost:8083/api/usuarios/restablecerContrasenia");
	    URL url = uri.toURL();

	    HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
	    conexion.setRequestMethod("PUT");
	    conexion.setRequestProperty("Content-Type", "application/json");
	    conexion.setDoOutput(true);

	    try (OutputStream os = conexion.getOutputStream()) {
	        os.write(usuarioJson.getBytes());
	        os.flush();
	    }

	    int codigoRespuesta = conexion.getResponseCode();

	    if (codigoRespuesta == HttpURLConnection.HTTP_OK) {
	        return true;
	    }

	    return false;
	}

}
