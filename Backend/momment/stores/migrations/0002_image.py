# Generated by Django 3.2.13 on 2023-03-13 16:13

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('stores', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(blank=True, null=True, upload_to='store_images')),
                ('store', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='stores.store')),
            ],
        ),
    ]