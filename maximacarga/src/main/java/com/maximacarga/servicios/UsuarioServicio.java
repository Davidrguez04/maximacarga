	package com.maximacarga.servicios;
	
	
	import org.springframework.http.HttpHeaders;
	import org.springframework.http.MediaType;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpClient;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.maximacarga.dtos.UsuarioDto;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
	
/**
 * Servicio web encargado de la gestión de usuarios.
 * Se comunica con la API para:
 * - Registro
 * - Activación de cuenta
 * - Login (obtención de detalles)
 * - Modificación de datos
 * - Cambio de contraseña
 * - Eliminación
 * - Recuperación de contraseña
 * - Gestión de foto
 */
	@Service
	public class UsuarioServicio {
	
		/**
		 * Envía un nuevo usuario a la API para su registro.
		 * Si la API devuelve token de activación,
		 * envía automáticamente el email con el enlace.
		 */
		public String enviarRegistroUsuario(UsuarioDto nuevoUsuario, HttpSession session) throws Exception {
		    System.out.println("➡️ Entrando a enviarRegistroUsuario");
	
		    // 0) Que el token lo genere la API (por si viene del formulario)
		    try { nuevoUsuario.setTokenActivacion(null); } catch (Exception ignore) {}
	
		    // 1) Serializar DTO a JSON
		    ObjectMapper mapper = new ObjectMapper();
		    mapper.registerModule(new JavaTimeModule());
		    mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	
		    String json = mapper.writeValueAsString(nuevoUsuario);
		    System.out.println("📤 JSON a enviar: " + json);
	
		    // 2) HttpClient
		    HttpClient client = HttpClient.newBuilder().build();
	
		    // 3) URL EXPLÍCITA (como la tienes)
		    URI uri = new URI("http://localhost:8083/api/usuarios/registrarUsuario");
		    HttpRequest request = HttpRequest.newBuilder()
		            .uri(uri)
		            .header("Content-Type", "application/json; charset=UTF-8")
		            .header("Accept", "application/json")
		            .POST(HttpRequest.BodyPublishers.ofString(json, StandardCharsets.UTF_8))
		            .build();
	
		    System.out.println("🔌 Enviando petición al servidor: " + uri);
	
		    // 4) Enviar y leer respuesta
		    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
		    int status = response.statusCode();
		    String body = response.body();
	
		    System.out.println("📡 Código de respuesta HTTP: " + status);
		    System.out.println("📩 Respuesta del servidor: " + body);
	
		    // 5) Éxito: 201 o 200
		    if (status == 201 || status == 200) {
		        // ✅ Leer token y correo DIRECTO del JSON (robusto ante nombres distintos)
		        JsonNode root = mapper.readTree(body);
		        String token = root.path("tokenActivacion").asText(null);
		        String email = root.path("correoElectronico").asText(null);
	
		        // (Opcional) Intento mapear a tu DTO para la sesión; si falla, no pasa nada
		        UsuarioDto usuarioParaSesion = null;
		        try {
		            usuarioParaSesion = mapper.readValue(body, UsuarioDto.class);
		        } catch (Exception ex) {
		            System.out.println("ℹ️ No se pudo mapear a UsuarioDto (no crítico): " + ex.getMessage());
		        }
	
		        if (token != null && email != null) {
		            String enlaceActivacion = "http://localhost:8080/activarCuenta?token="
		                    + URLEncoder.encode(token, StandardCharsets.UTF_8);
	
		            System.out.println("📧 Enviando email a " + email + " con enlace: " + enlaceActivacion);
		            try {
		                enviarCorreoActivacion(email, enlaceActivacion);
		                System.out.println("✅ Email de activación enviado");
		            } catch (Exception e) {
		                System.out.println("❌ Error enviando email: " + e.getMessage());
		                e.printStackTrace();
		                // No corto el flujo: el registro fue OK igualmente
		            }
	
		            // Guardar en sesión si procede
		            if (session != null) {
		                if (usuarioParaSesion != null) {
		                    session.setAttribute("usuario", usuarioParaSesion);
		                } else {
		                    session.setAttribute("usuarioEmail", email);
		                }
		            }
	
		            System.out.println("✅ Usuario registrado y proceso de email ejecutado");
		            return "Usuario registrado correctamente";
		        } else {
		            System.out.println("⚠️ La respuesta no trae tokenActivacion o correoElectronico");
		            return "Error: respuesta sin token de activación o sin correo";
		        }
	
		    } else {
		        System.out.println("⚠️ Error al registrar usuario");
		        return "Error al registrar usuario: HTTP " + status + " - " + body;
		    }
		}
	
		
		/**
		 * Envía correo HTML con enlace de activación.
		 */
		@Autowired
	    private JavaMailSender javaMailSender;
		 public void enviarCorreoActivacion(String destinatario, String enlaceActivacion) {
		        try {
		            MimeMessage mensaje = javaMailSender.createMimeMessage();
		            MimeMessageHelper helper = new MimeMessageHelper(mensaje, true, "UTF-8");
	
		            helper.setTo(destinatario);
		            helper.setFrom("david.rodriguez.alonso10@gmail.com");
		            helper.setSubject("Activa tu cuenta en Maxima Carga");
	
		            String contenidoHtml = """
		                <html><body>
		                  <h2>¡Bienvenido a Maxima Carga!</h2>
		                  <p>Gracias por registrarte. Para activar tu cuenta, haz clic en el siguiente enlace:</p>
		                  <p><a href="%s">Activar cuenta</a></p>
		                  <p>Este enlace expirará en 24 horas.</p>
		                  <p>Saludos,<br>El equipo de Maxima Carga</p>
		                </body></html>
		            """.formatted(enlaceActivacion);
	
		            helper.setText(contenidoHtml, true);
	
		            javaMailSender.send(mensaje);
		            System.out.println("Correo de activación enviado a "+ destinatario);
		        } catch (Exception e) {
		            System.out.println("Error al enviar correo de activación a " + destinatario+ e);
		        }
		    }
		 
		 /**
		  * Activa la cuenta enviando el token a la API.
		  * Devuelve true si la API responde 200 OK.
		  */
		 public boolean activarCuenta(String token) throws Exception {
			    System.out.println("➡️ Entrando a activarCuenta");
	
			    // Construir la URL con la base de la API (desde application.properties)
			    String url = "http://localhost:8083/api/usuarios/activarCuenta?token=" + URLEncoder.encode(token, StandardCharsets.UTF_8);
	
			    // Crear el cliente HTTP
			    HttpClient client = HttpClient.newBuilder().build();
	
			    // Construir la petición PUT (sin cuerpo)
			    HttpRequest request = HttpRequest.newBuilder()
			            .uri(new URI(url))
			            .header("Content-Type", "application/json")
			            .PUT(HttpRequest.BodyPublishers.noBody())
			            .build();
	
			    System.out.println("🔗 Enviando solicitud de activación a: " + url);
	
			    // Enviar petición y recibir respuesta
			    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
	
			    int status = response.statusCode();
			    String body = response.body();
	
			    System.out.println("📡 Código de respuesta activación: " + status);
			    System.out.println("📩 Cuerpo de respuesta activación: " + body);
	
			    // Interpretar resultado según código HTTP
			    if (status == 200) {
			        System.out.println("✅ Cuenta activada correctamente (API → 200 OK).");
			        return true;
			    } else if (status == 410) {
			        System.out.println("⚠️ Token caducado o ya usado (API → 410 Gone).");
			        return false;
			    } else if (status == 400) {
			        System.out.println("⚠️ Token inválido (API → 400 Bad Request).");
			        return false;
			    } else {
			        System.out.println("⚠️ Error al activar cuenta. Código HTTP: " + status);
			        return false;
			    }
			}
		 
		 /**
		  * Obtiene los detalles completos de un usuario por email.
		  */
		 public UsuarioDto obtenerDetallesUsuario(String email, String token) throws IOException, URISyntaxException {

			    URI uri = new URI("http://localhost:8083/api/usuarios/detalles?email=" + 
			                      URLEncoder.encode(email, "UTF-8"));

			    URL url = uri.toURL();
			    HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
			    conexion.setRequestMethod("GET");
			    conexion.setRequestProperty("Accept", "application/json");

			    int codigoRespuesta = conexion.getResponseCode();

			    if (codigoRespuesta == HttpURLConnection.HTTP_OK) {

			        BufferedReader in = new BufferedReader(
			                new InputStreamReader(conexion.getInputStream()));

			        StringBuilder response = new StringBuilder();
			        String inputLine;

			        while ((inputLine = in.readLine()) != null) {
			            response.append(inputLine);
			        }
			        in.close();

			        ObjectMapper mapper = new ObjectMapper();
			        mapper.registerModule(new JavaTimeModule());
			        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
			        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

			        UsuarioDto usuario = mapper.readValue(response.toString(), UsuarioDto.class);

			        System.out.println("USUARIO RECIBIDO DE API: " + usuario.getIdUsuario());

			        return usuario;
			    }

			    return null;
			}


		 /**
		  * Obtiene un usuario por su ID.
		  */
		 public UsuarioDto obtenerUsuarioPorId(Long id) throws IOException, URISyntaxException {

			    URI uri = new URI("http://localhost:8083/api/usuarios/" + id);
			    URL url = uri.toURL();

			    HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
			    conexion.setRequestMethod("GET");
			    conexion.setRequestProperty("Accept", "application/json");

			    int codigoRespuesta = conexion.getResponseCode();

			    if (codigoRespuesta == HttpURLConnection.HTTP_OK) {

			        BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getInputStream()));
			        StringBuilder response = new StringBuilder();
			        String inputLine;

			        while ((inputLine = in.readLine()) != null) {
			            response.append(inputLine);
			        }
			        in.close();

			        ObjectMapper mapper = new ObjectMapper();
			        mapper.registerModule(new JavaTimeModule());
			        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
			        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

			        return mapper.readValue(response.toString(), UsuarioDto.class);
			    }

			    return null;
			}

		 
		 /**
		  * Envía petición a la API para cambiar contraseña.
		  */
		 public String cambiarContrasenia(UsuarioDto usuario) throws IOException, URISyntaxException {
			    ObjectMapper mapper = new ObjectMapper();
			    String usuarioJson = mapper.writeValueAsString(usuario);
	
			    URI uri = new URI("http://localhost:8083/api/usuarios/cambiarContrasenia");
			    URL url = uri.toURL();
			    HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
			    conexion.setRequestMethod("PUT");
			    conexion.setRequestProperty("Content-Type", "application/json");
			    conexion.setDoOutput(true);
	
			    OutputStream os = conexion.getOutputStream();
			    os.write(usuarioJson.getBytes());
			    os.flush();
			    os.close();
	
			    int codigoRespuesta = conexion.getResponseCode();
			    if (codigoRespuesta == HttpURLConnection.HTTP_OK) {
			        return "success";
			    } else {
			        BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getErrorStream()));
			        StringBuilder errorResponse = new StringBuilder();
			        String inputLine;
			        while ((inputLine = in.readLine()) != null) {
			            errorResponse.append(inputLine);
			        }
			        in.close();
			        System.out.println("Error en cambio de contraseña: " + errorResponse.toString());
			        return "error";
			    }
			}
		 
		 /**
		  * Actualiza los datos del usuario en la API.
		  */
		 public String actualizarUsuario(UsuarioDto usuario) throws URISyntaxException, IOException {
			    // Convertir el objeto usuario actualizado a JSON
			    
			    ObjectMapper mapper = new ObjectMapper();
			    mapper.registerModule(new JavaTimeModule());
			    mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
			    String usuarioJson = mapper.writeValueAsString(usuario);
	
			    // Configurar la conexión HTTP para la solicitud PUT
			    URI uri = new URI("http://localhost:8083/api/usuarios/actualizarUsuario");
				URL url = uri.toURL();
			    HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
			    conexion.setRequestMethod("PUT");
			    conexion.setRequestProperty("Content-Type", "application/json");
			    conexion.setDoOutput(true);
	
			    // Enviar el JSON en el cuerpo de la solicitud
			    OutputStream os = conexion.getOutputStream();
			    os.write(usuarioJson.getBytes());
			    os.flush();
			    os.close();
	
			    // Leer la respuesta del servidor
			    int codigoRespuesta = conexion.getResponseCode();
			    if (codigoRespuesta == HttpURLConnection.HTTP_OK) {
			        // Si la respuesta es exitosa, retornamos un mensaje de éxito
			        BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getInputStream()));
			        StringBuilder response = new StringBuilder();
			        String inputLine;
	
			        while ((inputLine = in.readLine()) != null) {
			            response.append(inputLine);
			        }
			        in.close();
	
			        System.out.println("Respuesta de la API: " + response.toString());
			        return "success"; // Retornar el éxito si la API responde OK
			    } else {
			        // Si la respuesta no es OK, procesamos el error
			        BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getErrorStream()));
			        StringBuilder errorResponse = new StringBuilder();
			        String inputLine;
			        while ((inputLine = in.readLine()) != null) {
			            errorResponse.append(inputLine);
			        }
			        in.close();
			        System.out.println("Error al actualizar el usuario: " + errorResponse.toString());
			        return "error"; // Si la actualización falla, retornar "error"
			    }
			}
		 
		 /**
		  * Lista todos los usuarios (solo admin).
		  */
		 public List<UsuarioDto> listarUsuarios() throws IOException, URISyntaxException {

			    URI uri = new URI("http://localhost:8083/api/usuarios/listar");
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
			        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
			        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

			        // 🔥 LISTA DE USUARIOS
			        return mapper.readValue(
			                response.toString(),
			                new TypeReference<List<UsuarioDto>>() {}
			        );
			    }

			    return List.of(); // lista vacía si falla
			}
		 
		 /**
		  * Elimina un usuario por ID.
		  */
		 public String eliminarUsuario(Long idUsuario) {
			    try {
			        URI uri = new URI("http://localhost:8083/api/usuarios/eliminar/" + idUsuario);
			        HttpURLConnection conexion = (HttpURLConnection) uri.toURL().openConnection();
			        conexion.setRequestMethod("DELETE");
			        conexion.setRequestProperty("Accept", "application/json");

			        // Obtener código de respuesta
			        int codigoRespuesta = conexion.getResponseCode();

			        // Leer respuesta del servidor
			        BufferedReader in;
			        if (codigoRespuesta >= 200 && codigoRespuesta < 300) {
			            in = new BufferedReader(new InputStreamReader(conexion.getInputStream()));
			        } else {
			            in = new BufferedReader(new InputStreamReader(conexion.getErrorStream()));
			        }

			        StringBuilder response = new StringBuilder();
			        String line;
			        while ((line = in.readLine()) != null) {
			            response.append(line);
			        }
			        in.close();

			        System.out.println(">>> [WEB] Código respuesta DELETE usuario " + idUsuario + ": " + codigoRespuesta);
			        System.out.println(">>> [WEB] Respuesta DELETE usuario: " + response);

			        return codigoRespuesta >= 200 && codigoRespuesta < 300 ? "success" : "error";

			    } catch (Exception e) {
			        e.printStackTrace();
			        return "error";
			    }
			}
		 
		 
		 /**
		  * Lanza la solicitud de recuperación de contraseña en la API.
		  * 
		  * Envía una petición POST con el email como parámetro.
		  * La API se encarga de generar el token de recuperación.
		  */
		 
		 public void solicitarRecuperacion(String email) throws Exception {

			    URI uri = new URI("http://localhost:8083/api/usuarios/recuperar?email="
			            + URLEncoder.encode(email, StandardCharsets.UTF_8));

			    HttpURLConnection conexion = (HttpURLConnection) uri.toURL().openConnection();
			    conexion.setRequestMethod("POST");

			    conexion.getResponseCode(); // solo lanzamos la llamada
			}
		 
		    
		 /**
		  * Envía la foto del usuario a la API.
		  */
		 public void subirFoto(Long idUsuario, MultipartFile imagen) {

			    try {
			    	String url = "http://localhost:8083/api/usuarios/subirFoto/" + idUsuario;

			        RestTemplate restTemplate = new RestTemplate();

			        HttpHeaders headers = new HttpHeaders();
			        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

			        byte[] imagenBytes = imagen.getBytes();

			        HttpEntity<byte[]> request =
			                new HttpEntity<>(imagenBytes, headers);

			        restTemplate.exchange(
			                url,
			                HttpMethod.PUT,
			                request,
			                Void.class
			        );

			        System.out.println("FOTO ENVIADA A API");

			    } catch (Exception e) {
			        e.printStackTrace();
			    }
			}

		 /**
		  * Genera token de recuperación en la API.
		  */
		 public boolean generarTokenRecuperacion(String correoElectronico) throws Exception {

			    URI uri = new URI(
			        "http://localhost:8083/api/usuarios/recuperar?correoElectronico=" +
			        URLEncoder.encode(correoElectronico, StandardCharsets.UTF_8)
			    );

			    HttpURLConnection conexion =
			            (HttpURLConnection) uri.toURL().openConnection();

			    conexion.setRequestMethod("POST");

			    return conexion.getResponseCode() == 200;
			}
		 
		 /**
		  * Obtiene el token generado.
		  */
		 public String obtenerTokenRecuperacion(String correoElectronico) throws Exception {

			    URI uri = new URI(
			        "http://localhost:8083/api/usuarios/tokenRecuperacion?correoElectronico=" +
			        URLEncoder.encode(correoElectronico, StandardCharsets.UTF_8)
			    );

			    HttpURLConnection conexion =
			            (HttpURLConnection) uri.toURL().openConnection();

			    conexion.setRequestMethod("GET");

			    if (conexion.getResponseCode() == 200) {
			        BufferedReader in =
			                new BufferedReader(new InputStreamReader(conexion.getInputStream()));
			        return in.readLine();
			    }

			    return null;
			}

		 /**
		  * Envía correo con enlace de recuperación.
		  */
		 public void enviarCorreoRecuperacion(String destinatario, String enlace) {

			    try {
			        MimeMessage mensaje = javaMailSender.createMimeMessage();
			        MimeMessageHelper helper = new MimeMessageHelper(mensaje, true, "UTF-8");

			        helper.setTo(destinatario);
			        helper.setSubject("Recuperar contraseña - Máxima Carga");

			        helper.setText("""
			            <h3>Recuperación de contraseña</h3>
			            <p>Haz clic en el enlace para restablecer tu contraseña:</p>
			            <a href="%s">Restablecer contraseña</a>
			        """.formatted(enlace), true);

			        javaMailSender.send(mensaje);

			    } catch (Exception e) {
			        e.printStackTrace();
			    }
			}

		 /**
		  * Flujo completo de recuperación:
		  * - Genera token
		  * - Lo obtiene
		  * - Construye enlace
		  * - Envía email
		  */
		 public boolean enviarEnlaceRecuperacion(String correoElectronico) {

			    try {

			        if (!generarTokenRecuperacion(correoElectronico)) {
			            return false;
			        }

			        String token = obtenerTokenRecuperacion(correoElectronico);

			        if (token == null) {
			            return false;
			        }

			        String enlace =
			            "http://localhost:8080/restablecerContrasenia?token=" + token;

			        enviarCorreoRecuperacion(correoElectronico, enlace);

			        return true;

			    } catch (Exception e) {
			        e.printStackTrace();
			        return false;
			    }
			}



		 
	}
