# Generated by Django 3.2.13 on 2023-04-14 06:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cakes', '0002_cakeimage'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cakeimage',
            name='cake',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='image', to='cakes.cake'),
        ),
    ]
