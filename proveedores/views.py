from django.shortcuts import render, redirect, get_object_or_404
from .forms import ProveedorForm
from .models import Proveedor
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages



def proveedores(request):
    proveedores = Proveedor.objects.all()
    form = ProveedorForm()
    return render(request, 'proveedores/proveedores.html', {
        'proveedores': proveedores,
        'form': form,
        'editando': False
    })

def crear_proveedor(request):
    if request.method == 'POST':
        form = ProveedorForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('proveedores')
    return redirect('proveedores')

def editar_proveedor(request, pk):
    proveedor = get_object_or_404(Proveedor, pk=pk)
    if request.method == 'POST':
        form = ProveedorForm(request.POST, instance=proveedor)
        if form.is_valid():
            form.save()
            return redirect('proveedores')
    else:
        form = ProveedorForm(instance=proveedor)

    proveedores = Proveedor.objects.all()
    return render(request, 'proveedores/proveedores.html', {
        'proveedores': proveedores,
        'form': form,
        'editando': True,
        'proveedor_id': proveedor.id
    })

def eliminar_proveedor(request, proveedor_id):
    proveedor = get_object_or_404(Proveedor, id=proveedor_id)
    if request.method == 'POST':
        proveedor.delete()
        messages.success(request, "Proveedor eliminado exitosamente.")
        return redirect('proveedores')
    return render(request, 'proveedores/confirmar_eliminar_proveedor.html', {'proveedor': proveedor})
