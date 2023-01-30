from django.db import models
from stores.models import Store

class Calender(models.Model):
    class Meta:
        unique_together = (('date', 'store'),)
    date = models.DateField()
    deadline = models.IntegerField()
    closed = models.BooleanField(null=True, blank=True)
    max_order = models.IntegerField(null=True, blank=True)
    store = models.ForeignKey(Store, on_delete=models.CASCADE, related_name='calender')

class Group(models.Model):
    # class Meta:
    #     unique_together = (('calender', 'store'),)
    calender = models.ForeignKey(Calender, related_name='group', on_delete=models.CASCADE)
    # store = models.ForeignKey(Store, related_name='group', on_delete=models.CASCADE)
    group_max_order = models.IntegerField()

class Time(models.Model):
    pickup_time = models.TimeField()
    time_max_order = models.IntegerField(null=True, blank=True)
    group = models.ForeignKey(Group, on_delete=models.CASCADE, related_name='time')

class Day(models.Model):
    class Meta:
        unique_together = (('day', 'store'),)
    day = models.CharField(max_length=20)
    deadline = models.IntegerField(null=True, blank=True)
    store = models.ForeignKey(Store, on_delete=models.CASCADE, related_name='day')