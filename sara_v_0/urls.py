"""sara_v_0 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from clientes import views as clientes_views

from django.conf import settings
from django.conf.urls.static import static



urlpatterns = [
    path('admin/', admin.site.urls),
    path('select2/', include('django_select2.urls')),
    path('usuarios/', include('usuarios.urls')), #Rutas de appUsuarios
    path('', clientes_views.index, name='index'),  # vista index general
    path('clientes/', include('clientes.urls')),   # rutas de la appcliente
    path('proveedores/', include('proveedores.urls')),   # rutas de la appproveedor
    path('inventarios/', include('inventarios.urls')),   # rutas de la appproveedor

    
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)