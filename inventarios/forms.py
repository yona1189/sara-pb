from django import forms
from django_select2.forms import ModelSelect2Widget
from .models import Articulo, DetalleEntrada, EntradaFactura

class ArticuloForm(forms.ModelForm):
    class Meta:
        model = Articulo
        fields = ['nombre_art', 'no_referencia', 'presentacion', 'stock_min', 'stock_max']
        labels = {
            'nombre_art': 'Artículo',
            'no_referencia': 'No Referencia', 
            'presentacion': 'Presentación', 
            'stock_min': 'Stock mínimo', 
            'stock_max': 'Stock máximo',
        }

        widgets = {
            'nombre_art': forms.TextInput(attrs={'class': 'form-control','placeholder': 'Nombre del artículo'}),
            'no_referencia': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Digite la referencia para el artículo'}),
            'presentacion': forms.Select(attrs={'class': 'form-control'}),
            'stock_min': forms.NumberInput(attrs={'class': 'form-control', 'placeholder': 'Establecer cantidad mínima inventario'}),
            'stock_max': forms.NumberInput(attrs={'class': 'form-control', 'placeholder': 'Establecer cantidad máxima inventario' }),
        }

    def __init__(self, *args, **kwargs):
        super(ArticuloForm, self).__init__(*args, **kwargs)

        # 1. Marcar el campo como obligatorio (elimina los ---------)
        self.fields['presentacion'].required = True

        # 2. Reemplazar las opciones para que SOLO aparezca la personalizada
        self.fields['presentacion'].choices = [('', 'Seleccione una presentación')] + list(
            filter(lambda c: c[0] != '', self.fields['presentacion'].choices)
        )

#Agregar unidades a un articulo por factura
class DetalleEntradaForm(forms.ModelForm):
    factura_no = forms.CharField(
        label="Factura No",
        max_length=20,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ingrese número de factura '})
    )

    articulo = forms.ModelChoiceField(
        queryset=Articulo.objects.all(),
        widget=ModelSelect2Widget(
            model=Articulo,
            search_fields=['nombre_art__icontains'],
            attrs={'class': 'form-control', 'data-placeholder': 'Buscar artículo'}
        )
    )

    class Meta:
        model = DetalleEntrada
        fields = ['factura_no', 'articulo', 'cantidad']
        widgets = {
            'cantidad': forms.NumberInput(attrs={'class': 'form-control', 'placeholder': 'Ingrese cantidad'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.fields['factura_no'].widget.attrs.update({
            'class': 'form-control',
            'placeholder': 'Ingrese número de factura', 'hx-get': '/inventarios/detalle-factura-htmx/', 
            'hx-trigger': 'keyup changed delay:300ms',
            'hx-target': '#tabla-detalles',
            'autocomplete': 'off'
    })
        # Evita errores al no incluir 'factura' (es ForeignKey)
        #if 'factura' in self.fields:
        #    del self.fields['factura']