# Generated by Django 3.2.13 on 2023-01-31 15:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0015_alter_time_time_max_order'),
    ]

    operations = [
        migrations.AddField(
            model_name='group',
            name='group_ordered',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='time',
            name='time_ordered',
            field=models.IntegerField(default=0),
        ),
    ]
