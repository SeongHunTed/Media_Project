# Generated by Django 3.2.13 on 2023-03-14 01:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('stores', '0004_auto_20230314_0133'),
    ]

    operations = [
        migrations.AlterField(
            model_name='store',
            name='image1',
            field=models.ImageField(blank=True, default='store_images/store_image_default.png', null=True, upload_to='store_images/'),
        ),
    ]