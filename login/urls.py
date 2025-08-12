from django.urls import path
from .views import login_view, logout_view 
from . import views

urlpatterns = [
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('reporte-clientes/pdf/', views.exportar_clientes_pdf, name='reporte_clientes_pdf'),
    
    path('reporte-articulos/pdf/', views.exportar_articulos_pdf, name='reporte-articulos_pdf'),
    
    path('entradas_filtradas/', views.entradas_filtradas, name='entradas_filtradas'),

    path('entradas_salidas/', views.salidas_filtradas, name='salidas_filtradas'),
]