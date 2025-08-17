from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import ArticuloForm, DetalleEntradaForm, DetalleSalidaForm
from .models import Articulo, EntradaFactura, DetalleEntrada, DetalleSalida, SalidaFactura
from django.http import HttpResponse
from django.template.loader import render_to_string
from django.utils import timezone
from datetime import timedelta
from django.http import JsonResponse

def inventarios(request):
    articulos = Articulo.objects.all()
    form = ArticuloForm()
    return render(request, 'inventarios/inventarios.html', {
        'articulos': articulos,
        'form': form,
        'editando': False
    })



def crear_articulo(request):
    if request.method == 'POST':
        form = ArticuloForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('inventarios')
    return redirect('inventarios')

def editar_articulo(request, pk):
    articulo = get_object_or_404(Articulo, pk=pk)
    if request.method == 'POST':
        form = ArticuloForm(request.POST, instance=articulo)
        if form.is_valid():
            form.save()
            return redirect('inventarios')
    else:
        form = ArticuloForm(instance=articulo)

    articulos = Articulo.objects.all()
    return render(request, 'inventarios/inventarios.html', {
        'articulos': articulos,
        'form': form,
        'editando': True,
        'articulo_id': articulo.id
    })

def eliminar_articulo(request, articulo_id):
    articulo = get_object_or_404(Articulo, id=articulo_id)
    if request.method == 'POST':
        articulo.delete()
        messages.success(request, "articulo eliminado exitosamente.")
        return redirect('inventarios')
    return render(request, 'inventarios/confirmar_eliminar_articulo.html', {'articulo': articulo})

#Buscar articulos

def buscar_articulos_select2(request):
    term = request.GET.get('term', '').strip()
    results = []
    if len(term) >= 2:  #solo busca si tiene 2 o más letras
        articulos = Articulo.objects.filter(nombre_art__icontains=term)[:20]
        results = [{"id": art.id, "text": art.nombre_art} for art in articulos]
    return JsonResponse({"results": results})

def filtrar_articulo_tabla(request):
    termino = request.GET.get('q', '')
    if termino:
        articulos = Articulo.objects.filter(nombre_art__icontains=termino)
    else:
        articulos = Articulo.objects.all()
    return render(request, 'inventarios/tabla_articulos.html', {"articulos": articulos})



@login_required
def registrar_entrada(request):
    factura_no_prellenado = ''  # Inicializar valor del campo

    if request.method == 'POST':
        form = DetalleEntradaForm(request.POST)

        if form.is_valid():
            # 1. Extraer los datos del formulario
            factura_no = form.cleaned_data['factura_no']
            articulo = form.cleaned_data['articulo']
            cantidad = form.cleaned_data['cantidad']

            # 2. Guardar número para usarlo después
            factura_no_prellenado = factura_no

            # 3. Obtener o crear la factura
            factura, creada = EntradaFactura.objects.get_or_create(
                factura_no=factura_no,
                defaults={'usuario_responsable': request.user}
            )

            # 4. Crear detalle de entrada
            DetalleEntrada.objects.create(
                factura=factura,
                articulo=articulo,
                cantidad=cantidad
            )

            # 5. Sumar al stock del artículo
            articulo.stock += cantidad
            articulo.save()

            
            
            # Re-crear el formulario con el número de factura ya puesto
            form = DetalleEntradaForm(initial={'factura_no': factura_no})
            mensaje_html = render_to_string(
                'inventarios/mensaje_modal.html',
                {'mensaje': f"Agregado: {cantidad} unidades de '{articulo.nombre_art}' a la factura {factura_no}."},
                request=request
            )

            return JsonResponse({'modal': mensaje_html})

    else:
        # Primera vez que se carga la vista
        form = DetalleEntradaForm()

    return render(request, 'inventarios/registrar_entrada.html', {
        'form': form
    })

def detalle_factura_htmx(request):
    factura_no = request.GET.get('factura_no')
    detalles = []

    if factura_no:
        detalles = DetalleEntrada.objects.filter(factura__factura_no=factura_no).select_related('factura', 'articulo')

    return render(request, 'inventarios/detalle_factura_tabla.html', {
        'detalles': detalles
    })

#salidas

def mostrar_mensaje_modal(request):
    html = render_to_string('inventarios/mensaje_modal.html', {}, request=request)
    return JsonResponse({'html': html})

@login_required
def registrar_salida(request):
    if request.method == 'POST':
        form = DetalleSalidaForm(request.POST)
        if form.is_valid():
            factura_no = form.cleaned_data['factura_no']
            articulo = form.cleaned_data['articulo']
            cantidad = form.cleaned_data['cantidad']

            if articulo.stock < cantidad:
                mensaje_html = render_to_string(
                    'inventarios/mensaje_modal.html',
                    {'mensaje': f"No hay suficiente stock disponible. Stock actual: {articulo.stock}, solicitado: {cantidad}."},
                    request=request
                )

                form.data = form.data.copy()
                form.data['cantidad'] = ''

                html = render_to_string('inventarios/registrar_salida_form.html', {'form': form}, request=request)
                return JsonResponse({'modal': mensaje_html})

            # Stock suficiente
            factura, _ = SalidaFactura.objects.get_or_create(
                factura_no=factura_no,
                defaults={'usuario_responsable': request.user}
            )

            DetalleSalida.objects.create(
                factura=factura,
                articulo=articulo,
                cantidad=cantidad
            )

            articulo.stock -= cantidad
            articulo.save()

            mensaje_html = render_to_string(
                'inventarios/mensaje_modal.html',
                {'mensaje': f"Salida registrada: {cantidad} unidades de '{articulo.nombre_art}' en factura {factura_no}."},
                request=request
            )

            return JsonResponse({'modal': mensaje_html})
    else:
        form = DetalleSalidaForm()

    return render(request, 'inventarios/registrar_salida.html', {'form': form})

@login_required
def detalle_salida_htmx(request):
    factura_no = request.GET.get('factura_no')
    detalles = []

    if factura_no:
        detalles = DetalleSalida.objects.filter(factura__factura_no=factura_no).select_related('factura', 'articulo')

    return render(request, 'inventarios/detalle_salida_tabla.html', {
        'detalles': detalles
    })

# Mostrat facturas
@login_required
def listar_facturas(request):
    tipo = request.GET.get('tipo', 'entrada')
    
    ahora = timezone.localtime()  # Fecha y hora local
    inicio_dia = ahora.replace(hour=0, minute=0, second=0, microsecond=0)
    fin_dia = inicio_dia + timedelta(days=1)

    if tipo == 'salida':
        facturas = (
            SalidaFactura.objects
            .select_related('usuario_responsable')
            .filter(fecha_salida__gte=inicio_dia, fecha_salida__lt=fin_dia)
            .order_by('-fecha_salida')
        )
    else:
        facturas = (
            EntradaFactura.objects
            .select_related('usuario_responsable')
            .filter(fecha_entrada__gte=inicio_dia, fecha_entrada__lt=fin_dia)
            .order_by('-fecha_entrada')
        )

    return render(request, 'inventarios/listar_facturas.html', {
        'facturas': facturas,
        'tipo': tipo
    })