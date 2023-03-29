# Generated by Django 3.2.13 on 2023-01-26 17:39

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0002_auto_20230126_1738'),
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('calender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='group', to='calenders.calenderstore')),
            ],
        ),
    ]
