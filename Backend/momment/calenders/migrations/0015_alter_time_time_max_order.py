# Generated by Django 3.2.13 on 2023-01-30 18:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0014_auto_20230130_1749'),
    ]

    operations = [
        migrations.AlterField(
            model_name='time',
            name='time_max_order',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
