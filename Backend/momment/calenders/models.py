from django.db import models
from stores.models import Store

class Calender(models.Model):
    date = models.DateField()
    deadline = models.IntegerField()
    closed = models.BooleanField()
    max_order = models.IntegerField()

class Group(models.Model):
    class Meta:
        unique_together = (('calender', 'store'),)
    calender = models.ForeignKey(Calender, related_name='group', on_delete=models.CASCADE)
    store = models.ForeignKey(Store, related_name='group', on_delete=models.CASCADE)

class Time(models.Model):
    pickup_time = models.TimeField(primary_key=True)
    time_max_order = models.IntegerField()
    group = models.ForeignKey(Group, on_delete=models.CASCADE, related_name='time')

class Day(models.Model):
    class Meta:
        unique_together = (('day', 'store'),)
    day = models.CharField(max_length=20)
    deadline = models.IntegerField(null=True, blank=True)
    store = models.ForeignKey(Store, on_delete=models.CASCADE, related_name='day')