from django.conf import settings #trae el usuario personalizado
from django.db import models


class Articulo(models.Model):
    UNIDADES_PRESENTACION = [
        ('unidad', 'Unidad'),
        ('barril', 'Barril'),
        ('balde', 'Balde'),
        ('galon', 'Galón'),
        ('cuarto', 'Cuarto'),
    ]

    nombre_art = models.CharField(max_length=100, unique=True)
    no_referencia = models.CharField(max_length=50, unique=True)
    presentacion = models.CharField(max_length=10, choices=UNIDADES_PRESENTACION)
    stock = models.PositiveIntegerField(default=0)
    stock_min = models.PositiveIntegerField()
    stock_max = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.nombre_art} ({self.no_referencia})"


class EntradaFactura(models.Model):
    factura_no = models.CharField(max_length=20)
    fecha_entrada = models.DateField(auto_now_add=True)
    usuario_responsable = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT
    )

    def __str__(self):
        return f"Factura {self.factura_no}"

class DetalleEntrada(models.Model):
    factura = models.ForeignKey(EntradaFactura, on_delete=models.CASCADE, related_name='detalles')
    articulo = models.ForeignKey(Articulo, on_delete=models.PROTECT)
    cantidad = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.articulo.nombre} x {self.cantidad}"