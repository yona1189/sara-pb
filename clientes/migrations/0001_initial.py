# Generated by Django 5.2.3 on 2025-06-18 00:20

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Cliente',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombres', models.CharField(max_length=100)),
                ('identificacion', models.CharField(max_length=20, unique=True)),
                ('telefono', models.CharField(max_length=20)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('rol', models.CharField(default='Invitado', max_length=20)),
            ],
        ),
    ]
