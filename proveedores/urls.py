from django.urls import path
from . import views

urlpatterns = [
    path('proveedores/', views.proveedores, name='proveedores'),
    path('crear/', views.crear_proveedor, name='crear_proveedor'),
    path('editar/<int:pk>/', views.editar_proveedor, name='editar_proveedor'),
    path('eliminar/<int:proveedor_id>/', views.eliminar_proveedor, name='eliminar_proveedor'),
]