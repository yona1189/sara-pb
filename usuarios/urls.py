from django.urls import path
from .views import perfiles_accesos 
from . import views

urlpatterns = [
    path('', views.lista_usuarios, name='usuarios'),
    path('crear/', views.crear_usuario, name='crear_usuario'),
    path('editar/<int:usuario_id>/', views.editar_usuario, name='editar_usuario'),
    path('eliminar/<int:usuario_id>/', views.eliminar_usuario, name='eliminar_usuario'),
    path('perfiles-accesos/', views.perfiles_accesos, name='perfiles_accesos'),
    path('cambiar-tema/', views.cambiar_tema, name='cambiar_tema'),
]