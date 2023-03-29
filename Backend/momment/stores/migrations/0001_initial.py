# Generated by Django 3.2.13 on 2023-01-26 06:43

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Store',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('store_name', models.CharField(max_length=255)),
                ('store_intro', models.TextField(verbose_name='store intro')),
                ('store_opentime', models.TimeField(verbose_name='open time')),
                ('store_closetime', models.TimeField(verbose_name='close time')),
                ('store_digit', models.CharField(max_length=13)),
                ('store_address', models.CharField(max_length=255)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
