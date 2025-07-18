# Generated by Django 5.2.3 on 2025-06-22 02:14

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inventarios', '0003_rename_nombre_articulo_articulo_nombre_art'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name='articulo',
            name='nombre_art',
            field=models.CharField(max_length=100, unique=True),
        ),
        migrations.CreateModel(
            name='EntradaFactura',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('factura_no', models.CharField(max_length=20)),
                ('fecha_entrada', models.DateField(auto_now_add=True)),
                ('usuario_responsable', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='DetalleEntrada',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.PositiveIntegerField()),
                ('articulo', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventarios.articulo')),
                ('factura', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='detalles', to='inventarios.entradafactura')),
            ],
        ),
    ]
