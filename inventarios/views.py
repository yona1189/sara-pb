from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import ArticuloForm, DetalleEntradaForm 
from .models import Articulo, EntradaFactura, DetalleEntrada
from django.http import HttpResponse
from django.template.loader import render_to_string

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

            # 6. Mostrar mensaje y redirigir (con datos prellenados)
            messages.success(request, f"Agregado: {cantidad} unidades de '{articulo.nombre_art}' a la factura {factura_no}.")
            
            # Re-crear el formulario con el número de factura ya puesto
            form = DetalleEntradaForm(initial={'factura_no': factura_no})

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