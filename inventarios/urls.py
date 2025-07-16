from django.urls import path
from . import views

urlpatterns = [
    path('', views.inventarios, name='inventarios'),
    path('crear/', views.crear_articulo, name='crear_articulo'),
    path('editar/<int:pk>/', views.editar_articulo, name='editar_articulo'),
    path('eliminar/<int:articulo_id>/', views.eliminar_articulo, name='eliminar_articulo'),
    path('registrar_entrada/', views.registrar_entrada, name='registrar_entrada'),
    path('detalle-factura-htmx/', views.detalle_factura_htmx, name='detalle_factura_htmx'),
    path('registrar_salida/', views.registrar_salida, name='registrar_salida'),
    path('detalle-salida-htmx/', views.detalle_salida_htmx, name='detalle_salida_htmx'),
    path('listar_facturas/', views.listar_facturas, name='listar_facturas'),
]