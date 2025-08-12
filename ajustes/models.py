from django.db import models

def ruta_imagen_inicio(instance, filename):
    return f"empresa/{filename}"  # Se guardará en MEDIA_ROOT/empresa/

class ImagenInicio(models.Model):
    imagen = models.ImageField(upload_to=ruta_imagen_inicio)

    def __str__(self):
        return f"ImagenInicio {self.id}"
