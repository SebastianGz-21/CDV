import { checkAuth, infoUsuario, checkUserRole } from '../auth.js'; 

document.addEventListener('DOMContentLoaded', () => {
  const userData = checkAuth();
  if (!userData) return;

  // Actualizar información del usuario
  infoUsuario(userData);

  // Obtener elementos de los botones
  const newEmployeeBtn = document.querySelector('.admin-btn i.fa-user-plus')?.closest('.admin-btn');
  const viewEmployeesBtn = document.querySelector('.admin-btn i.fa-users')?.closest('.admin-btn');
  const viewStoresBtn = document.querySelector('.admin-btn i.fa-store')?.closest('.admin-btn');

  // Mostrar/ocultar botones según el rol
  switch(userData.rol) {
    case 'administrador':
      // Mostrar todos los botones (ya están visibles por defecto)
      break;
      
    case 'administrativo':
      // Ocultar solo "Nuevo Empleado"
      if (newEmployeeBtn) newEmployeeBtn.style.display = 'none';
      if (viewEmployeesBtn) viewEmployeesBtn.style.display = 'none';

      break;
      
    case 'inspector':
      // Ocultar "Nuevo Empleado" y "Ver Empleados"
      if (newEmployeeBtn) newEmployeeBtn.style.display = 'none';
      if (viewEmployeesBtn) viewEmployeesBtn.style.display = 'none';
      break;
  }

  // Manejar cierre de sesión
  document.querySelector('.logout-btn').addEventListener('click', () => {
    sessionStorage.removeItem('token');
    sessionStorage.removeItem('rolUsuario');
    sessionStorage.removeItem('nombreUsuario');
    window.location.href = "login.html";
  });

  // ===== LÓGICA PARA GUARDAR ORIGEN =====
  // Cuando se hace clic en botones que redirigen a páginas de lista
  const allButtons = document.querySelectorAll('.admin-btn, .submenu a, .fila-botones a');
  allButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      // Si es un enlace a lista-comercios, lista-transportes, bromatologia o form-registro-usuario
      if (btn.href && (btn.href.includes('lista-comercios') || 
                       btn.href.includes('lista-transportes') ||
                       btn.href.includes('bromatologia') ||
                       btn.href.includes('form-registro-usuario'))) {
        sessionStorage.setItem('originFrom', 'panel-principal');
      }
    });
  });
});
