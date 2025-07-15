# versión Python
FROM python:3.12

# dependencias necesarias para mysqlclient
RUN apt-get update \
    && apt-get install -y default-libmysqlclient-dev build-essential \
    && apt-get clean

# directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia e instala las dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del proyecto
COPY . .

# Expone el puerto 8000
EXPOSE 8000

# Comando por defecto para ejecutar el servidor de desarrollo
# se hace un retraso (10) mientras carga mysql para que docker se ejecute correctamente
CMD ["sh", "-c", "sleep 10 && python manage.py runserver 0.0.0.0:8000"]