from django.shortcuts import render, redirect, get_object_or_404
from .forms import ClienteForm
from .models import Cliente
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages

@login_required(login_url='/usuarios/login/')
def index(request):
    return render(request, 'clientes/index.html')



def clientes(request):
    clientes = Cliente.objects.all()
    form = ClienteForm()
    return render(request, 'clientes/clientes.html', {
        'clientes': clientes,
        'form': form,
        'editando': False
    })

def crear_cliente(request):
    if request.method == 'POST':
        form = ClienteForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('clientes')
    return redirect('clientes')

def editar_cliente(request, pk):
    cliente = get_object_or_404(Cliente, pk=pk)
    if request.method == 'POST':
        form = ClienteForm(request.POST, instance=cliente)
        if form.is_valid():
            form.save()
            return redirect('clientes')
    else:
        form = ClienteForm(instance=cliente)

    clientes = Cliente.objects.all()
    return render(request, 'clientes/clientes.html', {
        'clientes': clientes,
        'form': form,
        'editando': True,
        'cliente_id': cliente.id
    })

def eliminar_cliente(request, cliente_id):
    cliente = get_object_or_404(Cliente, id=cliente_id)
    if request.method == 'POST':
        cliente.delete()
        messages.success(request, "Cliente eliminado exitosamente.")
        return redirect('clientes')
    return render(request, 'clientes/confirmar_eliminar_cliente.html', {'cliente': cliente})
