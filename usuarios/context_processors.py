#para restringir el acceso a modulos
def es_admin(request):
    return {
        'es_admin': request.user.is_authenticated and (
            request.user.is_superuser or getattr(request.user, 'rol', '') == "Administrador"
        )
    }

def tema_usuario(request):
    if request.user.is_authenticated:
        return {'tema': request.user.tema} # Se establece el tema que el usuario guardo
    return {'tema': 'claro'}  # tema por defecto si no está logueado