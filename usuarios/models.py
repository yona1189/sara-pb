from django.contrib.auth.models import AbstractUser #Se extiende la clase usuarios de django para posteriormente personalizarla
from django.db import models

class UsuarioPersonalizado(AbstractUser):
    ROLES = [
        ('Administrador', 'Administrador'),
        ('Secretaria', 'Secretaria'),
        ('Invitado', 'Invitado'),
        ('Visitante', 'Visitante'),
    ]

    TEMA_CHOICES = [
        ('claro', 'Claro'),
        ('oscuro', 'Oscuro'),
    ]
    telefono = models.CharField(max_length=20, blank=True, null=True)
    tipo_documento = models.CharField(max_length=15, blank=True, null=True)
    documento = models.CharField(max_length=20, blank=True, null=True, unique=True)
    rol = models.CharField(max_length=15, choices=ROLES)
    tema = models.CharField(max_length=10, choices=TEMA_CHOICES, default='claro')

    def __str__(self):
        return self.username