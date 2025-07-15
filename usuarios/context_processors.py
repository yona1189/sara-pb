#para restringir el acceso a modulos
def es_admin(request):
    return {
        'es_admin': request.user.is_authenticated and (
            request.user.is_superuser or getattr(request.user, 'rol', '') == "Administrador"
        )
    }