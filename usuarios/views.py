from django.contrib.auth import authenticate
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.views import LoginView
from .forms import LoginForm
from .forms import UsuarioForm, UsuarioEditarForm, LoginForm
from .models import UsuarioPersonalizado
from django.contrib import messages
from django.contrib.auth.models import User, Group
from django.contrib.auth import get_user_model
from django.contrib.auth.decorators import user_passes_test
from django.contrib.auth.decorators import login_required





#def es_superusuario_o_admin(user):
#    return user.is_authenticated and (user.#is_superuser or user.rol == 'Administrador')



def solo_admin(view_func):
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated or not (request.user.is_superuser or request.user.rol == 'Administrador'):
            return redirect('index')  # o a donde tú definas
        return view_func(request, *args, **kwargs)
    return wrapper

@solo_admin
def lista_usuarios(request):
    usuarios = UsuarioPersonalizado.objects.all()
    form = UsuarioForm()  # Importante: se necesita al cargar la página
    context = {
        'usuarios': usuarios,
        'form': form,
        'editando': False,  # Es falso al crear un nuevo usuario
    }
    return render(request, 'usuarios/usuarios.html', context)

def crear_usuario(request):
    if request.method == 'POST':
        form = UsuarioForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Usuario creado exitosamente.')
            return redirect('usuarios')
        else:
            print(form.errors)  # 👈 Esto te mostrará los errores en la consola
            messages.error(request, 'Por favor corrige los errores.')
            return render(request, 'usuarios/usuarios.html', {
                'form': form,
                'usuarios': UsuarioPersonalizado.objects.all(),
                'mostrar_modal': True,
                'editando': False
            })
    else:
        form = UsuarioForm()
    return render(request, 'usuarios/usuarios.html', {
        'form': form,
        'usuarios': UsuarioPersonalizado.objects.all()
    })
    
def editar_usuario(request, usuario_id):
    usuario = get_object_or_404(UsuarioPersonalizado, id=usuario_id)

    if request.method == 'POST':
        form = UsuarioEditarForm(request.POST, instance=usuario)
        if form.is_valid():
            usuario = form.save(commit=False)

            nueva_password = form.cleaned_data.get("password1")
            if nueva_password:
                usuario.set_password(nueva_password)

            usuario.save()
            messages.success(request, " Usuario actualizado exitosamente.")
            return redirect('usuarios')
        else:
            messages.error(request, " Ocurrió un error al actualizar el usuario.")
    else:
        form = UsuarioEditarForm(instance=usuario)

    return render(request, 'usuarios/usuarios.html', {
        'form': form,
        'editando': True,
        'usuario_id': usuario.id,
        'usuarios': UsuarioPersonalizado.objects.all(),
        'mostrar_modal': True,
    })

def eliminar_usuario(request, usuario_id):
    usuario = get_object_or_404(UsuarioPersonalizado, id=usuario_id)
    if request.method == 'POST':
        usuario.delete()
        messages.success(request, "Usuario eliminado exitosamente.")
        return redirect('usuarios')
    return render(request, 'usuarios/confirmar_eliminar_usuario.html', {'usuario': usuario})

User = get_user_model()

def perfiles_accesos(request):
    usuarios = User.objects.all().select_related()
    grupos = Group.objects.all()
    return render(request, 'usuarios/perfiles_accesos.html', {
        'usuarios': usuarios,
        'grupos': grupos
    })

@login_required
def cambiar_tema(request):
    user = request.user
    user.tema = 'oscuro' if user.tema == 'claro' else 'claro'
    user.save()
    return redirect(request.META.get('HTTP_REFERER', '/'))