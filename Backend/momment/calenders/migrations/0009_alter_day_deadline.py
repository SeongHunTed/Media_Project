# Generated by Django 3.2.13 on 2023-01-27 07:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0008_day'),
    ]

    operations = [
        migrations.AlterField(
            model_name='day',
            name='deadline',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
