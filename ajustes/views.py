import os
import subprocess
from django.conf import settings
from django.http import FileResponse, HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from django.core.files.storage import FileSystemStorage
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from .forms import ImagenInicioForm
from .models import ImagenInicio
from django.template.loader import render_to_string
from django.http import JsonResponse

@login_required(login_url='/login/login/')
def ajustes(request):
    return render(request, 'ajustes/ajustes.html')

@login_required(login_url='/ajustes/restaurardatos/')
def restaurardatos(request):
    return render(request, 'ajustes/restaurardatos.html')

# Carpeta de backups dentro del proyecto
BACKUP_DIR = os.path.join(settings.BASE_DIR, 'backups')
os.makedirs(BACKUP_DIR, exist_ok=True)

# Función para obtener los datos de conexión desde settings
def get_db_credentials():
    db = settings.DATABASES['default']
    return db['NAME'], db['USER'], db['PASSWORD'], db['HOST'], db['PORT']


@login_required(login_url='/login/login/')
def hacer_backup(request):
    if not request.user.is_staff:
        return render(request, "ajustes/no_autorizado.html", {
            "razon": "No tienes permisos para crear una copia de seguridad."
        })

    if request.method == "POST":
        db_name, db_user, db_pass, db_host, db_port = get_db_credentials()
        nombre_archivo = "backup.sql"
        ruta_backup = os.path.join(BACKUP_DIR, nombre_archivo)

        comando = f"mysqldump -h {db_host} -P {db_port} -u {db_user} -p{db_pass} {db_name} > \"{ruta_backup}\""
        resultado = subprocess.run(comando, shell=True)

        if resultado.returncode == 0:
            url_descarga = reverse('descargar_backup')
            mensaje_html = render_to_string(
                'ajustes/mensaje_modal.html',
                {'mensaje': 'Copia de seguridad creada con éxito',
                 'url_descarga': url_descarga},
                request=request
            )
            return JsonResponse({'modal': mensaje_html})
        else:
            mensaje_html = render_to_string(
                'ajustes/mensaje_modal.html',
                {'mensaje': 'Error al crear la copia de seguridad',
                 'url_descarga': None},
                request=request
            )
            return JsonResponse({'modal': mensaje_html})

    return render(request, 'backup_form.html')


@login_required(login_url='/login/login/')
def descargar_backup(request):
    nombre_archivo = "backup.sql"
    ruta_backup = os.path.join(BACKUP_DIR, nombre_archivo)
    return FileResponse(open(ruta_backup, 'rb'), as_attachment=True, filename=nombre_archivo)


@login_required(login_url='/login/login/')
def restaurar_backup(request):
    if not request.user.is_staff:
          return render(request, "ajustes/no_autorizado.html", {"razon": "No tienes permisos para restaurar la base de datos"})

    if request.method == 'POST' and request.FILES.get('archivo_sql'):
        archivo_sql = request.FILES['archivo_sql']

        if not archivo_sql.name.endswith('.sql'):
            messages.error(request, "Solo se permiten archivos con extensión .sql.")
            return redirect(reverse('restaurar_backup'))

        fs = FileSystemStorage(location=BACKUP_DIR)
        filename = fs.save(archivo_sql.name, archivo_sql)
        filepath = os.path.join(BACKUP_DIR, filename)

        db_name, db_user, db_pass, db_host, db_port = get_db_credentials()
        comando = f"mysql -h {db_host} -P {db_port} -u {db_user} -p{db_pass} {db_name} < \"{filepath}\""

        resultado = subprocess.run(comando, shell=True)

       

        os.remove(filepath)

        return redirect(reverse('restaurar_backup'))

    return render(request, 'login/login.html')

#Cambiar imagen emporesa
@staff_member_required(login_url='/login/login/')
def cambiar_imagen_inicio(request):
    imagen_actual = ImagenInicio.objects.last()  # Tomamos la más reciente

    if request.method == 'POST':
        form = ImagenInicioForm(request.POST, request.FILES)
        if form.is_valid():
            ImagenInicio.objects.all().delete()  # Eliminamos anteriores
            form.save()
            
            return redirect('index')
        else:
            messages.error(request, "Error al subir la imagen.")
    else:
        form = ImagenInicioForm()

    return render(request, 'ajustes/cambiar_imagen_inicio.html', {
        'form': form,
        'imagen_actual': imagen_actual
    })