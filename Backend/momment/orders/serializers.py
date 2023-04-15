from rest_framework import serializers
from .models import *


class OrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Order
        fields = '__all__'

class ReviewSerializer(serializers.ModelSerializer):

    class Meta:
        model = Review
        fields = ('review', 'image', 'user')

class CartSerializer(serializers.ModelSerializer):

    store_name = serializers.CharField(source='cake.store.store_name')
    cake_name = serializers.CharField(source='cake.name')
    class Meta:
        model = Cart
        fields = '__all__'
