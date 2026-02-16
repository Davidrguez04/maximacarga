package com.maximacarga.dtos;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class UsuarioDto {
    // ---------------------------
    // Atributos actuales
    // ---------------------------
    private String apellido1 = "aaaaa";
    private String apellido2 = "aaaaa";
    private String nombreUsuario = "aaaaaa";
    private LocalDate fchNacUsu;
    private String apellidosUsuario = "aaaaaa";
    private String tokenActivacion = "aaaaa";
    Boolean activo=false;
    private String contraseniaActual = "aaaaa";
    private Long idUsuario;                      // Clave primaria
    private String fotoPerfil;
  

	private String movil;                 // Número de móvil
    private String correoElectronico;     // Email (máx. 50)
    private String tipoUsuario;           // Rol: ADMIN o USUARIO
    private String contrasena;            // Contraseña encriptada
    private byte[] imagenUsuario;
    private String imagenBase64;

    public byte[] getImagenUsuario() {
        return imagenUsuario;
    }

    public void setImagenUsuario(byte[] imagenUsuario) {
        this.imagenUsuario = imagenUsuario;
    }

    public String getImagenBase64() {
        return imagenBase64;
    }

    public void setImagenBase64(String imagenBase64) {
        this.imagenBase64 = imagenBase64;
    }
   

   

	

	

	
  

    


    // ---------------------------
    // Getters y Setters
    // ---------------------------
    
    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }
    
    public Long getIdUsuario() {
  		return idUsuario;
  	}

  	public void setIdUsuario(Long idUsuario) {
  		this.idUsuario = idUsuario;
  	}

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public LocalDate getFchNacUsu() {
        return fchNacUsu;
    }

    public void setFchNacUsu(LocalDate fchNacUsu) {
        this.fchNacUsu = fchNacUsu;
    }

    public String getApellidosUsuario() {
        return apellidosUsuario;
    }

    public void setApellidosUsuario(String apellidosUsuario) {
        this.apellidosUsuario = apellidosUsuario;
    }

    // --- Nuevos campos ---

   
   
    public Boolean getActivo() {
		return activo;
	}

	public void setActivo(Boolean activo) {
		this.activo = activo;
	}
    

    public String getMovil() {
        return movil;
    }

    public void setMovil(String movil) {
        this.movil = movil;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    public String getTokenActivacion() {
		return tokenActivacion;
	}

	public void setTokenActivacion(String tokenActivacion) {
		this.tokenActivacion = tokenActivacion;
	}
	public String getContraseniaActual() {
		return contraseniaActual;
	}

	public void setContraseniaActual(String contraseniaActual) {
		this.contraseniaActual = contraseniaActual;
	}
	
	
	
	
	
	// ---------------------------
    // Constructores
    // ---------------------------
    public UsuarioDto() {
        super();
    }

    

    public UsuarioDto(String apellido1, String apellido2, String nombreUsuario, LocalDate fchNacUsu,
			String apellidosUsuario, String tokenActivacion, Boolean activo, String contraseniaActual, Long idUsuario,
			String movil, String correoElectronico, String tipoUsuario, String contrasena) {
		super();
		this.apellido1 = apellido1;
		this.apellido2 = apellido2;
		this.nombreUsuario = nombreUsuario;
		this.fchNacUsu = fchNacUsu;
		this.apellidosUsuario = apellidosUsuario;
		this.tokenActivacion = tokenActivacion;
		this.activo = activo;
		this.contraseniaActual = contraseniaActual;
		this.idUsuario = idUsuario;
		this.movil = movil;
		this.correoElectronico = correoElectronico;
		this.tipoUsuario = tipoUsuario;
		this.contrasena = contrasena;
	}

	// ---------------------------
    // ToString
    // ---------------------------
    @Override
    public String toString() {
        return "UsuarioDto{" +
                "id=" + idUsuario +
                 + '\'' +
                ", movil='" + movil + '\'' +
                ", correoElectronico='" + correoElectronico + '\'' +
                ", tipoUsuario='" + tipoUsuario + '\'' +
                ", contrasena='" + (contrasena != null ? "****" : null) + '\'' +
                '}';
    }
}
