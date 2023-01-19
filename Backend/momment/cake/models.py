from django.db import models
from store.models import Store
# Create your models here.

class Cake(models.Model):
    name = models.CharField(max_length=40)
    price = models.IntegerField()
    store = models.ForeignKey(Store, on_delete=models.CASCADE)

class CakeSize(models.Model):
    size = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeFlavor(models.Model):
    flavor = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeColor(models.Model):
    color = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeDesign(models.Model):
    design = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeSideDeco(models.Model):
    side_deco = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeDeco(models.Model):
    deco = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeLettering(models.Model):
    lettering = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeFont(models.Model):
    font = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakePicture(models.Model):
    picture = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakePackage(models.Model):
    package = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)

class CakeCandle(models.Model):
    candle = models.CharField(max_length=40)
    price = models.IntegerField()
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)
    

# class Cake(models.Model):
#     name = models.CharField(max_length=40, unique=True)
#     size = models.ForeignKey(CakeSize, on_delete=models.CASCADE)
#     flavor = models.ForeignKey(CakeFlavor, on_delete=models.CASCADE)
#     color = models.ForeignKey(CakeColor, on_delete=models.CASCADE)
#     design = models.ForeignKey(CakeDesign, on_delete=models.CASCADE)
#     side_deco = models.ForeignKey(CakeSideDeco, on_delete=models.CASCADE, null=True, blank=True)
#     deco = models.ForeignKey(CakeDeco, on_delete=models.CASCADE, null=True, blank=True)
#     lettering = models.ForeignKey(CakeLettering, on_delete=models.CASCADE, null=True, blank=True)
#     font = models.ForeignKey(CakeFont, on_delete=models.CASCADE, null=True, blank=True)
#     picture = models.ForeignKey(CakePicture, on_delete=models.CASCADE, null=True, blank=True)
#     package = models.ForeignKey(CakePackage, on_delete=models.CASCADE)
#     candle = models.ForeignKey(CakeCandle, on_delete=models.CASCADE, null=True, blank=True)