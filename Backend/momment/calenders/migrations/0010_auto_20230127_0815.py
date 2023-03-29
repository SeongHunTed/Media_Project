# Generated by Django 3.2.13 on 2023-01-27 08:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('stores', '0001_initial'),
        ('calenders', '0009_alter_day_deadline'),
    ]

    operations = [
        migrations.AddField(
            model_name='calender',
            name='store',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='calender', to='stores.store'),
            preserve_default=False,
        ),
        migrations.AlterUniqueTogether(
            name='calender',
            unique_together={('date', 'store')},
        ),
    ]