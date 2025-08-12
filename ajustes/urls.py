from django.urls import path
from . import views

urlpatterns = [
    path('', views.ajustes, name='ajustes'),
    path('restaurardatos/', views.restaurardatos, name='restaurardatos'),
    path('backup/', views.hacer_backup, name='hacer_backup'),
    path('restaurar/', views.restaurar_backup, name='restaurar_backup'),
    path('cambiar-imagen/', views.cambiar_imagen_inicio, name='cambiar_imagen_inicio'),
]