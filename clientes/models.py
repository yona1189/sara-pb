from django.contrib.auth.models import AbstractUser
from django.db import models

class Cliente(models.Model):
    nombres = models.CharField(max_length=100)
    identificacion = models.CharField(max_length=20, unique=True)
    telefono = models.CharField(max_length=20)
    email = models.EmailField(unique=True)
    placa = models.CharField(max_length=10, default="N/A")

    def __str__(self):
        return f"{self.nombres} ({self.identificacion})"
