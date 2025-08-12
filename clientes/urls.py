from django.urls import path
from . import views

urlpatterns = [
    path('clientes/', views.clientes, name='clientes'),
    path('crear/', views.crear_cliente, name='crear_cliente'),
    path('editar/<int:pk>/', views.editar_cliente, name='editar_cliente'),
    path('eliminar/<int:cliente_id>/', views.eliminar_cliente, name='eliminar_cliente'),
    
]