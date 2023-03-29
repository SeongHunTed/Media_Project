from django.db import models
from accounts.models import User

# Create your models here.

class Store(models.Model):
    store_name = models.CharField(max_length=255)
    store_intro = models.TextField(verbose_name='store intro')
    store_opentime = models.TimeField(verbose_name='open time')
    store_closetime = models.TimeField(verbose_name='close time')
    store_digit = models.CharField(max_length=13)
    store_address = models.CharField(max_length=255)
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image1 = models.ImageField(default='store_images/store_image_default.png', upload_to='store_images/', null=True, blank=True)
    image2 = models.ImageField(upload_to='store_images/', null=True, blank=True)
    image3 = models.ImageField(upload_to='store_images/', null=True, blank=True)
    image4 = models.ImageField(upload_to='store_images/', null=True, blank=True)
    image5 = models.ImageField(upload_to='store_images/', null=True, blank=True)
