// Mostrar el modal
window.mostrarLogin = function() {
  const modal = document.getElementById("modalLogin");
  if (modal) {
    modal.style.display = "flex"; // O "block", depende de tu CSS
  } else {
    console.warn("⚠️ No se encontró el modal #modalLogin");
  }
};

// Cerrar el modal
window.cerrarLogin = function() {
  const modal = document.getElementById("modalLogin");
  if (modal) {
    modal.style.display = "none";
  }
};

// Si haces clic fuera del modal, también se cierra
window.onclick = function(event) {
  const modal = document.getElementById("modalLogin");
  if (event.target === modal) {
    modal.style.display = "none";
  }
};