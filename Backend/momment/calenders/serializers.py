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
        exclude = ('id', 'deadline', 'max_order', 'store')

class TimeSerializer(serializers.ModelSerializer):

    class Meta:
        model = Time
        fields = ['pickup_time', 'time_max_order', 'time_ordered']

class GroupSerializer(serializers.ModelSerializer):

    time = TimeSerializer(many=True)

    class Meta:
        model = Group
        fields = ['group_num', 'group_max_order', 'group_ordered', 'time']

class CalenderOrderSerializer(serializers.ModelSerializer):

    group = GroupSerializer(many=True)
    store_name = serializers.CharField(source='store.store_name')
    class Meta:
        model = Calender
        fields = (['date', 'deadline', 'closed', 'max_order', 'store_name', 'group'])
