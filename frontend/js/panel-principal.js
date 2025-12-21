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

  // Obtener botón de escanear QR
  const scanQRBtn = document.getElementById('btnEscanearQR');

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
      // Mostrar botón de escanear QR solo para inspectores
      if (scanQRBtn) scanQRBtn.style.display = 'inline-flex';
      break;
  }

  // Funcionalidad del botón escanear QR
  if (scanQRBtn) {
    scanQRBtn.addEventListener('click', iniciarEscaneoQR);
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

// Función para iniciar escaneo de QR
async function iniciarEscaneoQR() {
  // Primero cargar la librería
  try {
    await cargarLibreriaQR();
  } catch (err) {
    alert('Error al cargar el escáner. Intenta recargar la página.');
    return;
  }

  // Crear modal solo con la cámara
  const modalHTML = `
    <div id="qrScanModal" style="
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.95);
      z-index: 9999;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 20px;
    ">
      <div style="
        background: white;
        border-radius: 12px;
        padding: 25px;
        max-width: 500px;
        width: 100%;
        text-align: center;
      ">
        <h3 style="margin: 0 0 15px 0; color: #333;">Escanear Código QR</h3>
        <p style="color: #666; margin-bottom: 15px; font-size: 14px;">Apunta la cámara hacia el código QR del comercio</p>
        
        <div id="qrReader" style="width: 100%; margin-bottom: 15px;"></div>
        <div id="scanStatus" style="margin: 10px 0; color: #666; font-size: 14px;">⏳ Iniciando cámara...</div>

        <button id="cerrarScanQR" style="
          width: 100%;
          background: #6c757d;
          color: white;
          border: none;
          padding: 12px;
          border-radius: 6px;
          cursor: pointer;
          font-size: 16px;
          font-weight: bold;
          margin-top: 10px;
        ">
          <i class="fas fa-times"></i> Cancelar
        </button>
      </div>
    </div>
  `;

  document.body.insertAdjacentHTML('beforeend', modalHTML);

  const modal = document.getElementById('qrScanModal');
  const cerrarBtn = document.getElementById('cerrarScanQR');
  const qrReaderDiv = document.getElementById('qrReader');
  const scanStatus = document.getElementById('scanStatus');

  let html5QrCode = null;
  let camaraActiva = false;

  // Función para cerrar el modal
  const cerrarModal = () => {
    if (html5QrCode && camaraActiva) {
      html5QrCode.stop().catch(() => {});
    }
    modal.remove();
  };

  // Cerrar modal
  cerrarBtn.onclick = cerrarModal;

  // Iniciar cámara automáticamente
  try {
    html5QrCode = new Html5Qrcode("qrReader");
    
    await html5QrCode.start(
      { facingMode: "environment" },
      { 
        fps: 10, 
        qrbox: { width: 250, height: 250 },
        aspectRatio: 1.0
      },
      (decodedText) => {
        // QR detectado
        scanStatus.textContent = '✅ QR detectado!';
        scanStatus.style.color = '#28a745';
        
        camaraActiva = false;
        html5QrCode.stop().then(() => {
          procesarQR(decodedText);
          modal.remove();
        }).catch(() => {
          procesarQR(decodedText);
          modal.remove();
        });
      },
      (errorMessage) => {
        // Error o no detectado aún (esto es normal durante el escaneo)
      }
    );
    
    camaraActiva = true;
    scanStatus.textContent = '📷 Apunta al código QR';
    scanStatus.style.color = '#28a745';
    
  } catch (err) {
    console.error('Error al iniciar cámara:', err);
    scanStatus.textContent = '❌ No se pudo acceder a la cámara. Verifica los permisos.';
    scanStatus.style.color = '#dc3545';
    
    // Cambiar el botón a "Cerrar"
    cerrarBtn.innerHTML = '<i class="fas fa-times"></i> Cerrar';
  }
}

// Función auxiliar para cargar la librería QR
function cargarLibreriaQR() {
  return new Promise((resolve, reject) => {
    // Si ya está cargada
    if (typeof Html5Qrcode !== 'undefined') {
      resolve();
      return;
    }
    
    // Si ya se está cargando
    const existingScript = document.querySelector('script[src*="html5-qrcode"]');
    if (existingScript) {
      existingScript.onload = () => resolve();
      return;
    }
    
    const script = document.createElement('script');
    // Usar jsDelivr que está permitido en el CSP
    script.src = 'https://cdn.jsdelivr.net/npm/html5-qrcode@2.3.8/html5-qrcode.min.js';
    script.onload = () => {
      console.log('Librería QR cargada correctamente');
      resolve();
    };
    script.onerror = (err) => {
      console.error('Error al cargar librería QR:', err);
      reject(new Error('Error al cargar librería QR desde CDN'));
    };
    document.head.appendChild(script);
  });
}

// Función para procesar el QR detectado
function procesarQR(decodedText) {
  console.log('QR detectado:', decodedText);
  
  // Verificar si la URL es de un comercio
  if (decodedText.includes('comercio.html?id=')) {
    // Extraer la URL relativa
    const match = decodedText.match(/comercio\.html\?id=(\d+)/);
    if (match) {
      window.location.href = `comercio.html?id=${match[1]}`;
      return;
    }
  }
  
  if (decodedText.includes('/pages/comercio.html')) {
    const match = decodedText.match(/id=(\d+)/);
    if (match) {
      window.location.href = `comercio.html?id=${match[1]}`;
      return;
    }
  }
  
  // Buscar cualquier patrón id=numero
  const idMatch = decodedText.match(/id[=:](\d+)/i);
  if (idMatch) {
    window.location.href = `comercio.html?id=${idMatch[1]}`;
    return;
  }
  
  // Si solo es un número
  if (/^\d+$/.test(decodedText.trim())) {
    window.location.href = `comercio.html?id=${decodedText.trim()}`;
    return;
  }
  
  alert('Código QR no válido. No se pudo extraer el ID del comercio.');
}
