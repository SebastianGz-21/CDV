const nodemailer = require('nodemailer');
const PDFDocument = require('pdfkit');
const fs = require('fs');
const path = require('path');

// Configurar el transportador de correo
const transporter = nodemailer.createTransport({
    host: process.env.EMAIL_HOST || 'smtp.gmail.com',
    port: parseInt(process.env.EMAIL_PORT) || 587,
    secure: false,
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD
    }
});

/**
 * Generar PDF de constancia de alta de comercio
 */
async function generarPDFConstancia(datosComercio) {
    return new Promise((resolve, reject) => {
        try {
            const {
                nombreComercial,
                razonSocial,
                categoria,
                rubro,
                direccion,
                telefono,
                idComercio,
                qrPath
            } = datosComercio;

            // Crear directorio para PDFs si no existe
            const pdfDir = path.join(process.cwd(), 'uploads', 'constancias');
            if (!fs.existsSync(pdfDir)) {
                fs.mkdirSync(pdfDir, { recursive: true });
            }

            const pdfPath = path.join(pdfDir, `Constancia_Comercio_${idComercio}.pdf`);
            const doc = new PDFDocument({ margin: 50, size: 'A4' });
            const stream = fs.createWriteStream(pdfPath);

            doc.pipe(stream);

            // Header compacto
            doc.rect(0, 0, doc.page.width, 75).fill('#655577');
            
            doc.fontSize(18).fillColor('#ffffff')
               .text('Constancia de Alta de Comercio', 50, 20, { align: 'center' });
            
            doc.fontSize(9).fillColor('#ffffff')
               .text('Dirección de Calidad de Vida - Municipalidad de Santiago del Estero', 50, 50, { align: 'center' });

            // Número de habilitación destacado
            doc.fontSize(10).fillColor('#333333').font('Helvetica')
               .text('Número de Habilitación', 50, 95);
            
            doc.fontSize(22).fillColor('#655577').font('Helvetica-Bold')
               .text(`#${idComercio}`, 50, 108);

            // Línea separadora
            doc.moveTo(50, 140).lineTo(doc.page.width - 50, 140).stroke('#cccccc');

            // Datos del comercio
            doc.fontSize(13).fillColor('#655577').font('Helvetica-Bold')
               .text('Datos del Comercio', 50, 150);

            let y = 172;
            const lineHeight = 18;
            const colWidth = (doc.page.width - 150) / 2;
            const col1X = 50;
            const col2X = 50 + colWidth + 50;

            // Columna 1 - Nombre Comercial
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Nombre Comercial:', col1X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(nombreComercial, col1X, y + 10, { width: colWidth });
            
            // Columna 2 - Razón Social
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Razón Social:', col2X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(razonSocial || 'No especificado', col2X, y + 10, { width: colWidth });
            y += lineHeight * 1.6;

            // Columna 1 - Categoría
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Categoría:', col1X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(categoria, col1X, y + 10, { width: colWidth });
            
            // Columna 2 - Rubro
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Rubro:', col2X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(rubro, col2X, y + 10, { width: colWidth });
            y += lineHeight * 1.6;

            // Columna 1 - Dirección
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Dirección:', col1X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(direccion, col1X, y + 10, { width: colWidth });
            
            // Columna 2 - Teléfono
            doc.fontSize(10).fillColor('#655577').font('Helvetica-Bold');
            doc.text('Teléfono:', col2X, y);
            doc.fontSize(10).fillColor('#333333').font('Helvetica');
            doc.text(telefono, col2X, y + 10, { width: colWidth });
            y += lineHeight * 1.6 + 5;

            // Línea separadora
            doc.moveTo(50, y).lineTo(doc.page.width - 50, y).stroke('#cccccc');
            y += 10;

            // QR Code
            if (qrPath && fs.existsSync(path.join(process.cwd(), qrPath.replace(/^\//, '')))) {
                const qrFilePath = path.join(process.cwd(), qrPath.replace(/^\//, ''));
                
                doc.fontSize(11).fillColor('#655577').font('Helvetica-Bold')
                   .text('Código QR del Comercio', 50, y);
                y += 15;

                // Centrar QR
                const qrSize = 200;
                const qrX = (doc.page.width - qrSize) / 2;
                
                doc.image(qrFilePath, qrX, y, { width: qrSize, height: qrSize });
                y += qrSize + 8;

                doc.fontSize(10).fillColor('#666666').font('Helvetica')
                   .text('Los inspectores pueden escanear este código QR para verificar la habilitación', 50, y, { 
                       align: 'center',
                       width: doc.page.width - 100
                   });
                y += 12;
            }

            // Recuadro de importante compacto
            doc.rect(50, y, doc.page.width - 100, 40)
               .lineWidth(2)
               .strokeColor('#ffc107')
               .stroke();
            
            doc.fontSize(10).fillColor('#333333').font('Helvetica-Bold')
               .text('Importante:', 58, y + 7);
            
            doc.fontSize(10).fillColor('#333333').font('Helvetica')
               .text(`Conserve esta constancia como comprobante de registro. El número de habilitación #${idComercio} es su identificación única en el sistema.`, 
                     58, y + 18, { width: doc.page.width - 116 });
            
            y += 45;

            // Footer compacto
            doc.fontSize(9).fillColor('#666666').font('Helvetica')
               .text('Para consultas comuníquese con la Dirección de Calidad de Vida', 50, y, { align: 'center' });
            
            doc.fontSize(9).fillColor('#999999')
               .text(`Fecha de emisión: ${new Date().toLocaleDateString('es-AR', { 
                   day: '2-digit', 
                   month: '2-digit', 
                   year: 'numeric', 
                   hour: '2-digit', 
                   minute: '2-digit' 
               })}`, 50, y + 12, { align: 'center' });

            doc.end();

            stream.on('finish', () => {
                resolve(pdfPath);
            });

            stream.on('error', reject);

        } catch (error) {
            reject(error);
        }
    });
}

/**
 * Enviar email de alta de comercio al titular
 */
async function enviarEmailAltaComercio(datosComercio) {
    try {
        const {
            nombreComercial,
            razonSocial,
            emailTitular,
            categoria,
            rubro,
            direccion,
            telefono,
            idComercio,
            qrPath
        } = datosComercio;

        // Generar PDF de constancia
        const pdfPath = await generarPDFConstancia(datosComercio);
        
        // Construir ruta física del QR para mostrar en el email
        const qrFilePath = qrPath ? path.join(process.cwd(), qrPath.replace(/^\//, '')) : null;

        // Plantilla HTML del correo
        const htmlContent = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(to bottom, #c0a6dd, #655577); color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
        .info-box { background: white; padding: 20px; margin: 20px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .label { font-weight: bold; color: #655577; }
        .value { margin-bottom: 15px; }
        .qr-section { text-align: center; margin: 30px 0; padding: 20px; background: white; border-radius: 8px; }
        .qr-section img { max-width: 300px; border: 2px solid #c0a6dd; border-radius: 8px; }
        .footer { text-align: center; margin-top: 30px; padding: 20px; color: #666; font-size: 12px; }
        .important { background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0; }
        .print-info { background: #e8f4f8; border: 2px solid #0066cc; border-radius: 8px; padding: 20px; margin: 20px 0; text-align: center; }
        kbd { background: #f0f0f0; padding: 3px 8px; border: 1px solid #ccc; border-radius: 3px; font-family: monospace; }
        
        @media print {
            body { background: white; }
            .container { max-width: 100%; margin: 0; padding: 10mm; }
            .header { background: #655577 !important; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .content { background: white; padding: 0; }
            .info-box { box-shadow: none; border: 1px solid #ddd; page-break-inside: avoid; }
            .qr-section { page-break-inside: avoid; border: 1px solid #ddd; }
            .qr-section img { max-width: 250px; }
            .footer { page-break-before: avoid; border-top: 1px solid #ddd; font-size: 10px; }
            .important { background: white !important; border: 2px solid #ffc107; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .print-info { display: none; }
            .no-print { display: none; }
            a { color: #000; text-decoration: none; }
        }
        
        @page {
            size: A4;
            margin: 15mm;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏪 Alta de Comercio Registrada</h1>
            <p>Dirección de Calidad de Vida</p>
        </div>
        
        <div class="content">
            <h2>Estimado/a ${razonSocial || 'Titular'},</h2>
            
            <p>Le informamos que su comercio ha sido registrado exitosamente en nuestro sistema.</p>
            
            <div class="info-box">
                <h3 style="color: #655577; margin-top: 0;">📋 Datos del Comercio</h3>
                
                <div class="value">
                    <span class="label">Número de Habilitación:</span><br>
                    <strong style="font-size: 20px; color: #655577;">#${idComercio}</strong>
                </div>
                
                <div class="value">
                    <span class="label">Nombre Comercial:</span><br>
                    ${nombreComercial}
                </div>
                
                <div class="value">
                    <span class="label">Razón Social:</span><br>
                    ${razonSocial || 'No especificado'}
                </div>
                
                <div class="value">
                    <span class="label">Categoría:</span><br>
                    ${categoria}
                </div>
                
                <div class="value">
                    <span class="label">Rubro:</span><br>
                    ${rubro}
                </div>
                
                <div class="value">
                    <span class="label">Dirección:</span><br>
                    ${direccion}
                </div>
                
                <div class="value">
                    <span class="label">Teléfono:</span><br>
                    ${telefono}
                </div>
            </div>

            ${qrFilePath ? `
            <div class="qr-section">
                <h3 style="color: #655577;">📱 Código QR de su Comercio</h3>
                <p>Este código QR permite acceder rápidamente a la información de su comercio:</p>
                <img src="cid:qrcode" alt="Código QR del comercio">
                <p style="font-size: 12px; color: #666; margin-top: 15px;">
                    Guarde este código QR. Los inspectores podrán escanearlo para verificar su habilitación.
                </p>
            </div>
            ` : ''}
            
            <div class="important">
                <strong>⚠️ Importante:</strong><br>
                Conserve este correo como comprobante de registro. 
                El número de habilitación <strong>#${idComercio}</strong> es su identificación única en el sistema.
            </div>
            
            <div class="print-info">
                <h3 style="color: #0066cc; margin-top: 0;">📄 Constancia Oficial</h3>
                <p style="margin: 10px 0; font-size: 14px;">
                    Este correo incluye un archivo PDF adjunto con la <strong>Constancia de Alta de Comercio</strong>
                </p>
                <p style="margin: 10px 0; font-size: 14px;">
                    📎 <strong>Archivo adjunto:</strong> Constancia_Comercio_#${idComercio}.pdf
                </p>
                <p style="margin: 10px 0; font-size: 12px; color: #666;">
                    Descargue el PDF para imprimirlo o guardarlo como comprobante oficial
                </p>
            </div>
            
            <p style="margin-top: 30px;">
                Para cualquier consulta o trámite relacionado con su comercio, 
                por favor comuníquese con la Dirección de Calidad de Vida.
            </p>
        </div>
        
        <div class="footer">
            <p class="no-print">Este es un correo automático, por favor no responda a este mensaje.</p>
            <p><strong>Dirección de Calidad de Vida</strong></p>
            <p>Municipalidad - Sistema de Gestión de Comercios</p>
            <p style="margin-top: 10px; font-size: 10px;">Fecha de emisión: ${new Date().toLocaleDateString('es-AR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' })}</p>
        </div>
    </div>
</body>
</html>
        `;

        // Texto plano alternativo
        const textContent = `
ALTA DE COMERCIO REGISTRADA
Dirección de Calidad de Vida

Estimado/a ${razonSocial || 'Titular'},

Le informamos que su comercio ha sido registrado exitosamente en nuestro sistema.

DATOS DEL COMERCIO:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Número de Habilitación: #${idComercio}
Nombre Comercial: ${nombreComercial}
Razón Social: ${razonSocial || 'No especificado'}
Categoría: ${categoria}
Rubro: ${rubro}
Dirección: ${direccion}
Teléfono: ${telefono}

IMPORTANTE:
Conserve este correo como comprobante de registro.
El número de habilitación #${idComercio} es su identificación única en el sistema.

CONSTANCIA OFICIAL:
Este correo incluye un archivo PDF adjunto con la Constancia de Alta de Comercio.
Archivo adjunto: Constancia_Comercio_#${idComercio}.pdf
Descargue el PDF para imprimirlo o guardarlo como comprobante oficial.

Para cualquier consulta o trámite relacionado con su comercio,
por favor comuníquese con la Dirección de Calidad de Vida.

---
Este es un correo automático, por favor no responda a este mensaje.
Dirección de Calidad de Vida
Municipalidad - Sistema de Gestión de Comercios
Fecha de emisión: ${new Date().toLocaleDateString('es-AR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' })}
        `;

        const mailOptions = {
            from: process.env.EMAIL_FROM || '"Calidad de Vida" <noreply@calidaddevida.gob.ar>',
            to: emailTitular,
            subject: `✅ Alta de Comercio - Habilitación #${idComercio} - ${nombreComercial}`,
            text: textContent,
            html: htmlContent
        };

        // Adjuntos
        mailOptions.attachments = [];
        
        // Adjuntar PDF de constancia
        if (fs.existsSync(pdfPath)) {
            mailOptions.attachments.push({
                filename: `Constancia_Comercio_${idComercio}.pdf`,
                path: pdfPath
            });
        }
        
        // Adjuntar QR como imagen embebida en el email
        if (qrFilePath && fs.existsSync(qrFilePath)) {
            mailOptions.attachments.push({
                filename: `QR_Comercio_${idComercio}.png`,
                path: qrFilePath,
                cid: 'qrcode'
            });
        }

        const info = await transporter.sendMail(mailOptions);
        console.log('✅ Email enviado:', info.messageId);
        return { success: true, messageId: info.messageId };

    } catch (error) {
        console.error('❌ Error al enviar email:', error);
        return { success: false, error: error.message };
    }
}

module.exports = {
    enviarEmailAltaComercio
};
