# Generated by Django 3.2.13 on 2023-04-14 10:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('stores', '0006_alter_store_image1'),
    ]

    operations = [
        migrations.AlterField(
            model_name='store',
            name='store_digit',
            field=models.CharField(max_length=14),
        ),
    ]