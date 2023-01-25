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




# 상품 상세 페이지용
class Location(models.Model):
    locate = models.CharField(max_length=24, primary_key=True)

class Flavor(models.Model):
    flavor = models.CharField(max_length=100, primary_key=True)

class Price(models.Model):
    price_range = models.CharField(max_length=100, primary_key=True)

class CakeInfo(models.Model):
    info = models.TextField(max_length=1024)
    locate = models.ForeignKey(Location, on_delete=models.CASCADE)
    flavor = models.ForeignKey(Flavor, on_delete=models.CASCADE)
    price_range = models.ForeignKey(Price, on_delete=models.CASCADE)
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)
