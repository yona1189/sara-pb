import pytest
from usuarios.models import UsuarioPersonalizado
from django.contrib.auth import get_user_model

User = get_user_model()

@pytest.mark.django_db
def test_crear_usuario_personalizado():
    usuario = User.objects.create_user(
        username='maria123',
        password='passwordseguro123',
        email='maria@example.com',
        telefono='3001234567',
        tipo_documento='CC',
        documento='123456789',
        rol='Administrador'
    )

    assert User.objects.count() == 1
    assert usuario.username == 'maria123'
    assert usuario.telefono == '3001234567'
    assert usuario.tipo_documento == 'CC'
    assert usuario.documento == '123456789'
    assert usuario.rol == 'Administrador'
    assert usuario.check_password('passwordseguro123')  # Valida que la contraseña se haya guardado correctamente

@pytest.mark.django_db
def test_actualizar_usuario_personalizado():
    usuario = User.objects.create_user(
        username='luis456',
        password='clave1234',
        email='luis@example.com',
        telefono='3112345678',
        tipo_documento='TI',
        documento='987654321',
        rol='Invitado'
    )

    usuario.rol = 'Editor'
    usuario.telefono = '3151112233'
    usuario.save()

    usuario_refrescado = User.objects.get(pk=usuario.pk)
    assert usuario_refrescado.rol == 'Editor'
    assert usuario_refrescado.telefono == '3151112233'