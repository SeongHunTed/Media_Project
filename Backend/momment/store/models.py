from django.db import models
from accounts.models import User

# Create your models here.

class Store(models.Model):
    store_name          = models.CharField(max_length=255)
    store_intro         = models.TextField(verbose_name='store intro')
    store_opentime      = models.TimeField(verbose_name='open time')
    store_close         = models.TimeField(verbose_name='close time')
    store_digit         = models.CharField(max_length=13)
    store_address       = models.CharField(max_length=255)
    user_id             = models.ForeignKey(User, on_delete=models.CASCADE)