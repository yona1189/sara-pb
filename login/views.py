from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.views import LoginView
from .forms import LoginForm
from ajustes.models import ImagenInicio 
from django.contrib import messages
from django.conf import settings
import os
from reportlab.platypus import Image

from django.contrib.auth.decorators import user_passes_test
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import LoginView
from django.shortcuts import render
from django.db.models import Q
from datetime import datetime
from django.template.loader import render_to_string
from django.http import JsonResponse
from inventarios.models import DetalleEntrada
from inventarios.models import DetalleSalida
from inventarios.models import Articulo

from django.http import HttpResponse
from clientes.models import Cliente
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.lib.units import inch
from reportlab.platypus import Table, TableStyle, SimpleDocTemplate, Paragraph, Spacer, Image
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
import io
from django.utils.timezone import make_aware
from datetime import datetime
from django.utils.timezone import make_aware

#Clase para cargar el login
class LoginUsuario(LoginView):
    template_name = 'login/login.html'

#iniciar sesion
def login_view(request):
    if request.method == 'POST':
        form = LoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('index')  # Redirige al index
    else:
        form = LoginForm()
    return render(request, 'login/login.html', {'form': form})

#Cerrar sesion
def logout_view(request):
    logout(request)
    return redirect('login')  # Redirige al login después de cerrar sesión

@login_required(login_url='/login/login/')
def index(request):
    imagen_actual = ImagenInicio.objects.last()
    return render(request, 'login/index.html', {
        'imagen_actual': imagen_actual})

@login_required
def exportar_clientes_pdf(request):
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=letter, topMargin=40, bottomMargin=40, leftMargin=30, rightMargin=30)
    elements = []
    styles = getSampleStyleSheet()

    # Estilo para el título
    estilo_titulo = ParagraphStyle(
        name='TituloCentral',
        parent=styles['Title'],
        alignment=1,  # Centrado
        fontSize=18,
        leading=22,
        spaceAfter=20,
        textColor=colors.HexColor("#1c3f95")
    )

    # logotipo 
    #logo_path = 'static/img/logo.png'  # Ruta estática al logo de sara
    logo_path = os.path.join(settings.BASE_DIR, 'static', 'img', 'logo.png')
    im = Image(logo_path, width=100, height=50)
    try:
        logo = Image(logo_path, width=1.2 * inch, height=1.2 * inch)
        logo.hAlign = 'LEFT'
        elements.append(logo)
    except:
        pass

    # Título
    titulo = Paragraph("REPORTE GENERAL DE CLIENTES", estilo_titulo)
    elements.append(titulo)
    elements.append(Spacer(1, 0.2 * inch))

    # Cabecera de la tabla
    data = [['Nombre', 'Cédula', 'Teléfono', 'Email', 'Placa']]

    # Cuerpo de la tabla
    clientes = Cliente.objects.all() 
    for cliente in clientes:
        data.append([
            cliente.nombres,
            cliente.identificacion,
            cliente.telefono,
            cliente.email,
            cliente.placa
        ])

    # Anchos de columnas
    col_widths = [2 * inch, 1.2 * inch, 1.2 * inch, 2.2 * inch, 1.2 * inch]

    # Tabla
    table = Table(data, colWidths=col_widths)

    # Estilo para tabla con alternancia de colores
    estilo_tabla = TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#2b5797")),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 9.5),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('TOPPADDING', (0, 1), (-1, -1), 6),
        ('GRID', (0, 0), (-1, -1), 0.25, colors.grey),
    ])

    # Alternancia de filas
    for i in range(1, len(data)):
        bg_color = colors.whitesmoke if i % 2 == 0 else colors.lightgrey
        estilo_tabla.add('BACKGROUND', (0, i), (-1, i), bg_color)

    table.setStyle(estilo_tabla)
    elements.append(table)

    # Generar PDF
    doc.build(elements)

    buffer.seek(0)
    return HttpResponse(buffer, content_type='application/pdf', headers={
        'Content-Disposition': 'attachment; filename="reporte_clientes.pdf"'
    })

@login_required
def exportar_articulos_pdf(request):
    buffer = io.BytesIO()
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="reporte_articulos.pdf"'

    doc = SimpleDocTemplate(buffer, pagesize=letter)
    elements = []
    styles = getSampleStyleSheet()

      # logotipo 
    #logo_path = 'static/img/logo.png'  # Ruta estática al logo de sara
    logo_path = os.path.join(settings.BASE_DIR, 'static', 'img', 'logo.png')
    im = Image(logo_path, width=100, height=50)
    try:
        logo = Image(logo_path, width=1.2 * inch, height=1.2 * inch)
    except:
        logo = ''
    # Título estilizado
    titulo_estilo = ParagraphStyle(
        name="TituloPersonalizado",
        fontSize=16,
        leading=20,
        alignment=1,  # Centro del párrafo (no de la celda)
        textColor=colors.HexColor("#003366"),
    )
    titulo = Paragraph("<b>REPORTE GENERAL DE ARTÍCULOS</b>", titulo_estilo)
    # Crear tabla con dos columnas: logo | título
    encabezado = Table(
        [[logo, titulo]],
        colWidths=[1.5 * inch, 5.5 * inch]
    )
    encabezado.setStyle(TableStyle([
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('ALIGN', (1, 0), (1, 0), 'CENTER'),
        ('LEFTPADDING', (0, 0), (-1, -1), 0),
        ('RIGHTPADDING', (0, 0), (-1, -1), 0),
        ('TOPPADDING', (0, 0), (-1, -1), 0),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 0),
    ]))
    elements.append(encabezado)
    elements.append(Spacer(1, 0.2 * inch))  # Espaciado inferior

    
    # Cabecera
    data = [[
        'Nombre del Artículo',
        'Referencia',
        'Presentación',
        'Stock Actual',
        'Stock Mínimo',
        'Stock Máximo'
    ]]

    # Consulta de artículos
    articulos = Articulo.objects.all().order_by('nombre_art')
    for art in articulos:
        data.append([
            art.nombre_art,
            art.no_referencia,
            dict(Articulo.UNIDADES_PRESENTACION).get(art.presentacion, art.presentacion),
            art.stock,
            art.stock_min,
            art.stock_max
        ])

    # Tabla con estilo bonito
    tabla = Table(data, colWidths=[2.5 * inch, 1.2 * inch, 1.2 * inch, 1 * inch, 1 * inch, 1 * inch])
    estilo_tabla = TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#003366")),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('TOPPADDING', (0, 1), (-1, -1), 6),
        ('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
    ])
    tabla.setStyle(estilo_tabla)

    elements.append(tabla)
    doc.build(elements)

    pdf = buffer.getvalue()
    buffer.close()
    response.write(pdf)
    return response



def entradas_filtradas(request):
    rango = request.GET.get('rango_fecha')
    entradas = DetalleEntrada.objects.select_related(
        'factura', 'articulo', 'factura__usuario_responsable'
    )
    resultados = []

    if rango:
        try:
            fecha_inicio_str, fecha_fin_str = [f.strip() for f in rango.split(' - ')]
            fecha_inicio = make_aware(datetime.strptime(fecha_inicio_str, '%Y-%m-%d'))
            fecha_fin = make_aware(datetime.strptime(fecha_fin_str, '%Y-%m-%d').replace(
                hour=23, minute=59, second=59
            ))

            entradas = entradas.filter(factura__fecha_entrada__range=[fecha_inicio, fecha_fin])
            resultados = list(entradas)
        except Exception as e:
            print(f"Error parsing fecha: {e}")
            resultados = []
    else:
        entradas = []        

    return render(request, 'login/tabla_entradas.html', {
        'entradas': entradas,
        'resultados': resultados,
        'hay_resultados': bool(resultados),
        'mostrar_modal': not bool(resultados),
    })

def salidas_filtradas(request):
    rango = request.GET.get('rango_fecha2')
    salidas = DetalleSalida.objects.select_related(
        'factura', 'articulo', 'factura__usuario_responsable'
    )
    resultados = []

    if rango:
        try:
            fecha_inicio_str, fecha_fin_str = [f.strip() for f in rango.split(' - ')]
            fecha_inicio = make_aware(datetime.strptime(fecha_inicio_str, '%Y-%m-%d'))
            fecha_fin = make_aware(datetime.strptime(fecha_fin_str, '%Y-%m-%d').replace(
                hour=23, minute=59, second=59
            ))

            salidas = salidas.filter(factura__fecha_salida__range=[fecha_inicio, fecha_fin])
            resultados = list(salidas)
        except Exception as e:
            print(f"Error parsing fecha: {e}")
            resultados = []
    else:
        salidas = []        

    return render(request, 'login/tabla_salidas.html', {
        'salidas': salidas,
        'resultados': resultados,
        'hay_resultados': bool(resultados),
        'mostrar_modal': not bool(resultados),
    })
