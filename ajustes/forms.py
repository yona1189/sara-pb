from django import forms
from .models import ImagenInicio

class ImagenInicioForm(forms.ModelForm):
    class Meta:
        model = ImagenInicio
        fields = ['imagen']
        widgets = {
            'imagen': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }