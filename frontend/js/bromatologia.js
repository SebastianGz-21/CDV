  import { logout, checkAuth, infoUsuario } from '../auth.js';

document.addEventListener('DOMContentLoaded', () => {
  const userData = checkAuth(); 
  if (!userData) return;

  infoUsuario(userData);

  // --- Control por rol ---
  const rol = userData.rol;

  // Capturar los bloques funcionales
  const bloqueGestionar = document.querySelector('.bloque-gestionar');
  const bloqueConsultas = document.querySelector('.bloque-consultas');
  const otrosBloques = document.querySelectorAll(
    '.bloque-submenu:not(.bloque-gestionar):not(.bloque-consultas)'
  );

  if (rol === 'administrador') {
    // Todo visible
  } else if (rol === 'administrativo') {
    if (bloqueGestionar) bloqueGestionar.style.display = 'none';
  } else if (rol === 'inspector') {
    // Solo dejar visible Consultas
    if (bloqueGestionar) bloqueGestionar.style.display = 'none';
    otrosBloques.forEach(bloque => bloque.style.display = 'none');
  } else {
    console.warn('Rol no reconocido:', rol);
  }

  // --- Botón cerrar sesión ---
  function cerrarSesion() {
    sessionStorage.removeItem('token');
    sessionStorage.removeItem('rolUsuario');
    sessionStorage.removeItem('nombreUsuario');
    window.location.href = "login.html";
  }

  document.querySelector('.logout-btn').addEventListener('click', cerrarSesion);

  // --- Botón Alta Comercio y Titular ---
  const altaBtn = document.querySelector('.boton-alta');
  if (altaBtn) {
    altaBtn.addEventListener('click', () => {
      window.location.href = '../pages/form-alta-completo.html';
    });
  }

  // ===== LÓGICA PARA GUARDAR ORIGEN =====
  // Cuando se hace clic en renovación de comercios o transporte
  const renovacionLinks = document.querySelectorAll('.bloque-renovacion a');
  renovacionLinks.forEach(link => {
    link.addEventListener('click', () => {
      sessionStorage.setItem('originFrom', 'bromatologia');
    });
  });

  // Cuando se hace clic en Ver Comercios o Ver Vehículos
  const listaLinks = document.querySelectorAll('.fila-botones a[href*="lista-"]');
  listaLinks.forEach(link => {
    link.addEventListener('click', () => {
      sessionStorage.setItem('originFrom', 'bromatologia');
    });
  });
});
