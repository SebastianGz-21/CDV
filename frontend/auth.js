
// ✅ Usar sessionStorage en lugar de localStorage (más seguro)
export function getToken() {
  return sessionStorage.getItem('token');
}

// Cerrar sesión
export function logout(redirectURL = '/pages/login.html') {
  // ✅ Cambiar de localStorage a sessionStorage
  sessionStorage.removeItem('token');
  sessionStorage.removeItem('rolUsuario');
  sessionStorage.removeItem('nombreUsuario');
  window.location.href = redirectURL;
}

export function parseaToken(token) {
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      atob(base64).split('').map(c =>
        '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)
      ).join('')
    );
    return JSON.parse(jsonPayload);
  } catch (e) {
    console.error('Token inválido:', e);
    return null;
  }
}

export function checkAuth() {
  const token = getToken();
  if (!token) {
    // Guardar URL actual antes de redirigir al login
    const currentUrl = window.location.href;
    if (!currentUrl.includes('login.html')) {
      sessionStorage.setItem('redirectAfterLogin', currentUrl);
    }
    logout();
    return null;
  }

  const userData = parseaToken(token);
  if (!userData) {
    logout();
    return null;
  }

  return userData;
}

export function infoUsuario(userData) {
  const userInfoElements = {
    img: document.querySelector('.user-info img'),
    name: document.querySelector('.user-info h3'),
    role: document.querySelector('.user-info p')
  };

  // Búsqueda flexible de campos nombre/name
  const nombre = userData.nombre || userData.name || userData.usuario || '';
  if (nombre) userInfoElements.name.textContent = nombre;
  
  // Búsqueda flexible de campos rol/role
  const rol = userData.rol || userData.role || '';
  if (rol) userInfoElements.role.textContent = rol;
  
  // if (userData.imagen) userInfoElements.img.src = userData.imagen; 
}

export function checkUserRole(requiredRole) {
  const token = getToken();
  if (!token) return false;
  
  const userData = parseaToken(token);
  if (!userData || !userData.rol) return false;

  // Jerarquía de roles: admin > empleado > inspector
  const roleHierarchy = {
    'admin': 3,
    'empleado': 2,
    'inspector': 1
  };

  return roleHierarchy[userData.rol] >= roleHierarchy[requiredRole];
}