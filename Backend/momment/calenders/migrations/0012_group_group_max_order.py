# Generated by Django 3.2.13 on 2023-01-29 00:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0011_auto_20230127_0840'),
    ]

    operations = [
        migrations.AddField(
            model_name='group',
            name='group_max_order',
            field=models.IntegerField(default=10),
            preserve_default=False,
        ),
    ]