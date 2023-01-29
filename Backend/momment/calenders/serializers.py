from rest_framework import serializers
from .models import *
from stores.models import Store
from stores.serializers import StoreSerializer

class DaySerializer(serializers.ModelSerializer):

    class Meta:
        model = Day
        exclude = ('id', 'store',)

class CalenderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Calender
        exclude = ('id',)