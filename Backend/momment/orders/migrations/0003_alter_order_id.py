# Generated by Django 3.2.13 on 2023-02-02 07:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0002_auto_20230201_1744'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='id',
            field=models.DecimalField(decimal_places=0, max_digits=9999999999, primary_key=True, serialize=False),
        ),
    ]
