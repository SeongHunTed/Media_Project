# Generated by Django 3.2.13 on 2023-02-02 07:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0003_alter_order_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='pickup_date',
            field=models.DateField(),
        ),
    ]