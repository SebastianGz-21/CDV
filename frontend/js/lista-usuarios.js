import { checkAuth, infoUsuario } from '../auth.js';

document.addEventListener('DOMContentLoaded', async () => {
    const userData = checkAuth();
    if (!userData) return;

    infoUsuario(userData);

    // ===== LÓGICA PARA BOTÓN DE VOLVER DINÁMICO =====
    // Guardar el origen cuando venimos de panel principal
    function setVolverOrigin() {
        const referrer = document.referrer;
        if (!referrer.includes('lista-usuarios')) {
            sessionStorage.setItem('originFrom', 'panel-principal');
        }
    }

    // Actualizar el botón de volver según el origen
    function updateBtnVolverUsuarios() {
        const btnVolver = document.getElementById('btnVolverUsuarios');
        const origin = sessionStorage.getItem('originFrom') || 'panel-principal';
        
        if (origin === 'panel-principal') {
            btnVolver.href = '../pages/panel-principal.html';
            btnVolver.title = 'Volver al panel principal';
        }
    }

    // Guardar origen para el botón volver en form-registro-usuario
    const btnNuevoEmpleado = document.getElementById('btnNuevoEmpleado');
    if (btnNuevoEmpleado) {
      btnNuevoEmpleado.addEventListener('click', () => {
        sessionStorage.setItem('originFrom', 'lista-usuarios');
      });
    }

    setVolverOrigin();
    updateBtnVolverUsuarios();

    // Estado en memoria
    let usuariosFuente = [];
    let paginaActual = 1;
    const itemsPorPagina = 10;

    // Elementos DOM
    const inputBuscar = document.getElementById('buscarUsuario');
    const filtroArea = document.getElementById('filtroArea');
    const filtroRol = document.getElementById('filtroRol');
    const filtroEstado = document.getElementById('filtroEstado');
    const btnBuscar = document.getElementById('btn-buscar');
    const btnReset = document.getElementById('btn-reset');

    // Función para cargar usuarios
    async function cargarUsuarios() {
        try {
            const response = await fetch('/api/auth/usuarios', {
                headers: {
                    'Authorization': `Bearer ${sessionStorage.getItem('token')}`
                }
            });
            
            if (!response.ok) {
                throw new Error('Error al cargar usuarios');
            }
            
            const usuarios = await response.json();
            console.log('Usuarios cargados:', usuarios.map(u => ({ id: u.id_empleado, nombre: u.nombre, area: u.area })));
            
            // Ordenar por fecha de alta (desc), fallback por id
            usuarios.sort((a, b) => {
                const fa = a.fecha_alta || a.fecha_registro || a.created_at || null;
                const fb = b.fecha_alta || b.fecha_registro || b.created_at || null;
                if (fa && fb) return new Date(fb) - new Date(fa);
                return (b.id_empleado || 0) - (a.id_empleado || 0);
            });
            
            usuariosFuente = usuarios;
            poblarFiltros(usuariosFuente);
            aplicarFiltrosYBusqueda();
        } catch (error) {
            console.error('Error:', error);
            alert('Error al cargar usuarios: ' + error.message);
        }
    }

    // Función para mostrar usuarios en la tabla
    function mostrarUsuarios(usuarios) {
        const tbody = document.querySelector('#usuariosTable tbody');
        tbody.innerHTML = '';

        // Calcular paginación
        const totalItems = usuarios.length;
        const totalPaginas = Math.ceil(totalItems / itemsPorPagina);
        const inicio = (paginaActual - 1) * itemsPorPagina;
        const fin = inicio + itemsPorPagina;
        const usuariosEnPagina = usuarios.slice(inicio, fin);

        // Actualizar contador total
        document.getElementById('totalEmpleados').textContent = `Cantidad de empleados: ${totalItems}`;

        // Actualizar información de paginación
        document.getElementById('info-pagina').textContent = `Página ${paginaActual} de ${totalPaginas}`;
        document.getElementById('btn-anterior').disabled = paginaActual <= 1;
        document.getElementById('btn-siguiente').disabled = paginaActual >= totalPaginas;

        // Mostrar usuarios de la página actual
        usuariosEnPagina.forEach(usuario => {
            const tr = document.createElement('tr');
            
            if (!usuario.activo) {
               tr.classList.add('fila-inactiva');
            }
            
            tr.innerHTML = `
                <td>${usuario.nombre || '-'}</td>
                <td>${usuario.apellido || '-'}</td>
                <td>${usuario.dni || '-'}</td>
                <td>${usuario.area || '-'}</td>
                <td>${usuario.rol || '-'}</td>
                <td>${usuario.activo ? 'Activo' : 'Inactivo'}</td>
                <td>
                    <a href="form-registro-usuario.html?id=${usuario.id_empleado}" class="btn-action btn-edit">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    ${usuario.activo
                        ? `<button class="btn-action btn-delete" data-id="${usuario.id_empleado}"><i class="fas fa-trash-alt"></i> Dar de baja</button>`
                        : `<button class="btn-action btn-activate" data-id="${usuario.id_empleado}"><i class="fas fa-user-check"></i> Reactivar</button>`
                    }
                </td>
            `;

            tbody.appendChild(tr);
        });

        // Agregar event listeners para los botones de eliminar
        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', () => desactivarUsuario(btn.dataset.id));
        });
   
        document.querySelectorAll('.btn-activate').forEach(btn => {
            btn.addEventListener('click', () => activarUsuario(btn.dataset.id));
        });
    }

    // Búsqueda, filtros y sugerencias
    function poblarFiltros(data) {
        if (!data) return;
        // Solo poblamos el filtro de roles ya que las áreas están fijas en el HTML
        const roles = Array.from(new Set(data.map(u => u.rol).filter(Boolean))).sort();
        if (filtroRol) {
            filtroRol.innerHTML = '<option value="">Todos</option>' + 
                roles.map(r => `<option value="${r}">${r}</option>`).join('');
        }
    }

    function aplicarFiltrosYBusqueda() {
        let data = usuariosFuente.slice();
        const q = (inputBuscar?.value || '').trim();
        const soloNumeros = q.replace(/\D+/g, '');

        if (q.length > 0) {
            if (soloNumeros.length > 0 && /^[0-9]+$/.test(q)) {
                // Buscar DNI que comience con los números ingresados
                data = data.filter(u => String(u.dni || '').startsWith(soloNumeros));
            } else {
                const qLower = q.toLowerCase();
                data = data.filter(u => 
                    (u.nombre || '').toLowerCase().includes(qLower) || 
                    (u.apellido || '').toLowerCase().includes(qLower)
                );
            }
        }

        const vArea = filtroArea?.value || '';
        const vRol = filtroRol?.value || '';
        const vEstado = filtroEstado?.value || '';
        
        if (vArea) {
            data = data.filter(u => {
                const userArea = (u.area || '').toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
                const selectedArea = vArea.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
                return userArea === selectedArea;
            });
        }
        if (vRol) data = data.filter(u => (u.rol || '').toLowerCase() === vRol.toLowerCase());
        if (vEstado) data = data.filter(u => vEstado === 'activo' ? !!u.activo : !u.activo);

        mostrarUsuarios(data);
        renderizarSugerenciasBusqueda(q, data);
    }

    function aplicarFiltrosYBusquedaConReset() {
        // Resetear a página 1 cuando se aplican filtros
        paginaActual = 1;
        aplicarFiltrosYBusqueda();
    }

    function renderizarSugerenciasBusqueda(q, dataFiltrada) {
        const contId = 'buscarSugerencias';
        let cont = document.getElementById(contId);
        if (!inputBuscar) return;
        
        if (!cont) {
            cont = document.createElement('div');
            cont.id = contId;
            cont.style.position = 'absolute';
            cont.style.top = '100%';
            cont.style.left = '0';
            cont.style.right = '0';
            cont.style.zIndex = '1050';
            cont.style.background = '#fff';
            cont.style.border = '1px solid rgba(0,0,0,0.125)';
            cont.style.borderTop = 'none';
            cont.style.maxHeight = '260px';
            cont.style.overflowY = 'auto';
            cont.style.display = 'none';
            
            const group = inputBuscar.closest('.input-group');
            if (group) {
                group.style.position = 'relative';
                group.appendChild(cont);
            }
        }

        if (!q || q.length < 2) {
            cont.style.display = 'none';
            cont.innerHTML = '';
            return;
        }
        
        const sample = dataFiltrada.slice(0, 8);
        if (sample.length === 0) {
            cont.style.display = 'none';
            cont.innerHTML = '';
            return;
        }
        
        cont.innerHTML = sample.map((u, idx) => `
            <button type="button" class="list-group-item list-group-item-action" data-idx="${idx}" style="display:block;width:100%;text-align:left;">
                <div class="d-flex justify-content-between"> 
                    <span>${u.apellido || ''} ${u.nombre || ''}</span>
                    <small class="text-muted">${u.dni || ''}</small>
                </div>
            </button>
        `).join('');
        
        cont.className = 'list-group';
        cont.style.display = 'block';
        
        Array.from(cont.querySelectorAll('button')).forEach((btn, idx) => {
            btn.addEventListener('click', () => {
                const u = sample[idx];
                inputBuscar.value = String(u.dni || '').length ? String(u.dni) : `${u.apellido || ''} ${u.nombre || ''}`.trim();
                cont.style.display = 'none';
                cont.innerHTML = '';
                aplicarFiltrosYBusqueda();
            });
        });
    }

    // Función para crear debounce
    function crearDebounce(fn, delay) {
        let t;
        return function() {
            clearTimeout(t);
            t = setTimeout(() => fn.apply(this, arguments), delay);
        };
    }

    const debouncedBuscar = crearDebounce(() => aplicarFiltrosYBusquedaConReset(), 200);
    
    // Event Listeners
    if (inputBuscar) {
        inputBuscar.addEventListener('input', debouncedBuscar);
    }
    
    if (filtroArea) {
        filtroArea.addEventListener('change', aplicarFiltrosYBusquedaConReset);
    }
    
    if (filtroRol) {
        filtroRol.addEventListener('change', aplicarFiltrosYBusquedaConReset);
    }
    
    if (filtroEstado) {
        filtroEstado.addEventListener('change', aplicarFiltrosYBusquedaConReset);
    }

    if (btnBuscar) {
        btnBuscar.addEventListener('click', aplicarFiltrosYBusquedaConReset);
    }

    if (btnReset) {
        btnReset.addEventListener('click', () => {
            if (inputBuscar) inputBuscar.value = '';
            if (filtroArea) filtroArea.value = '';
            if (filtroRol) filtroRol.value = '';
            if (filtroEstado) filtroEstado.value = '';
            
            // Resetear select de roles
            if (filtroRol) {
                const roles = Array.from(new Set(usuariosFuente.map(u => u.rol).filter(Boolean))).sort();
                filtroRol.innerHTML = '<option value="">Todos</option>' + 
                    roles.map(r => `<option value="${r}">${r}</option>`).join('');
            }
            
            aplicarFiltrosYBusquedaConReset();
        });
    }

    // Event Listeners para paginación
    document.getElementById('btn-anterior')?.addEventListener('click', () => {
        if (paginaActual > 1) {
            paginaActual--;
            aplicarFiltrosYBusqueda();
        }
    });

    document.getElementById('btn-siguiente')?.addEventListener('click', () => {
        const totalItems = usuariosFuente.length;
        const totalPaginas = Math.ceil(totalItems / itemsPorPagina);
        if (paginaActual < totalPaginas) {
            paginaActual++;
            aplicarFiltrosYBusqueda();
        }
    });

    // Función para eliminar usuario
    async function desactivarUsuario(id) {
        if (!confirm('¿Está seguro que desea dar de baja este usuario?')) return;

        try {
            const response = await fetch(`/api/auth/desactivar/${id}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${sessionStorage.getItem('token')}`
                }
            });

            if (!response.ok) {
                throw new Error('Error al dar de baja al usuario');
            }

            alert('Usuario dado de baja con éxito');
            cargarUsuarios();
        } catch (error) {
            console.error('Error:', error);
            alert('Error al dar de baja al usuario: ' + error.message);
        }
    }

    // Función para dar de alta usuario
    async function activarUsuario(id) {
        try {
            const response = await fetch(`/api/auth/activar/${id}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${sessionStorage.getItem('token')}`
                }
            });

            if (!response.ok) {
                throw new Error('Error al dar de alta al usuario.');
            }

            alert('Usuario dado de alta con éxito');
            cargarUsuarios();
        } catch (error) {
            console.error('Error:', error);
            alert('Error al dar de alta al usuario: ' + error.message);
        }
    }

    // Manejar cierre de sesión
    document.querySelector('.logout-btn').addEventListener('click', () => {
        sessionStorage.removeItem('token');
        window.location.href = "login.html";
    });

    // Cargar usuarios al iniciar
    await cargarUsuarios();
});