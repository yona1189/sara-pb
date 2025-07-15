from django.urls import path
from . import views

urlpatterns = [
    path('', views.inventarios, name='inventarios'),
    path('crear/', views.crear_articulo, name='crear_articulo'),
    path('editar/<int:pk>/', views.editar_articulo, name='editar_articulo'),
    path('eliminar/<int:articulo_id>/', views.eliminar_articulo, name='eliminar_articulo'),
    path('registrar_entrada/', views.registrar_entrada, name='registrar_entrada'),
    path('detalle-factura-htmx/', views.detalle_factura_htmx, name='detalle_factura_htmx')
]