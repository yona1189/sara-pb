# Generated by Django 5.2.3 on 2025-06-22 16:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inventarios', '0004_alter_articulo_nombre_art_entradafactura_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='articulo',
            name='stock',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
