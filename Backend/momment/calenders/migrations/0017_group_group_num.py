# Generated by Django 3.2.13 on 2023-01-31 16:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('calenders', '0016_auto_20230131_1508'),
    ]

    operations = [
        migrations.AddField(
            model_name='group',
            name='group_num',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
    ]