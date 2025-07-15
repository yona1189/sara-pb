from django.contrib.auth.models import AbstractUser
from django.db import models

class Proveedor(models.Model):
    nombre_empresa = models.CharField(max_length=30)
    nit = models.CharField(max_length=20)
    nombre_propietario = models.CharField(max_length=100)
    telefono = models.CharField(max_length=20)
    direccion = models.CharField(max_length=50)
    email = models.EmailField(unique=True) 

    def __str__(self):
        return f"{self.nombre_propietario} ({self.nit})"
