from django.db import models
from accounts.models import User
from cakes.models import Cake
from stores.models import Store


class Status(models.Model):
    status = models.CharField(max_length = 30, primary_key=True)

class Order(models.Model):
    id = models.DecimalField(decimal_places=0, max_digits=9999999999, primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    store = models.ForeignKey(Store, on_delete=models.CASCADE)
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)
    status = models.ForeignKey(Status, on_delete=models.CASCADE)
    option = models.TextField()
    price = models.IntegerField()
    pickup_date = models.DateField()
    pickup_time = models.TimeField(null=True, blank=True)
    ordered_at = models.DateField(auto_created=True)

class Review(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    cake = models.ForeignKey(Cake, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    review = models.TextField()
    image = models.TextField(null=True, blank=True)