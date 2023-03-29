# Generated by Django 3.2.13 on 2023-02-01 13:00

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('stores', '0001_initial'),
        ('cakes', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Status',
            fields=[
                ('status', models.CharField(max_length=30, primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('ordered_at', models.DateField(auto_created=True)),
                ('id', models.DecimalField(decimal_places=10, max_digits=9999999999, primary_key=True, serialize=False)),
                ('option', models.TextField()),
                ('price', models.IntegerField()),
                ('cake', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='cakes.cake')),
                ('status', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='orders.status')),
                ('store', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='stores.store')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]