# Generated by Django 3.2.13 on 2023-03-14 01:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('stores', '0003_auto_20230314_0113'),
    ]

    operations = [
        migrations.AlterField(
            model_name='store',
            name='image2',
            field=models.ImageField(blank=True, null=True, upload_to='store_images/'),
        ),
        migrations.AlterField(
            model_name='store',
            name='image3',
            field=models.ImageField(blank=True, null=True, upload_to='store_images/'),
        ),
        migrations.AlterField(
            model_name='store',
            name='image4',
            field=models.ImageField(blank=True, null=True, upload_to='store_images/'),
        ),
        migrations.AlterField(
            model_name='store',
            name='image5',
            field=models.ImageField(blank=True, null=True, upload_to='store_images/'),
        ),
    ]
