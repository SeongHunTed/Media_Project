from rest_framework import serializers
from .models import *
from cakes.serializers import CakeImageSerializer


class OrderSerializer(serializers.ModelSerializer):

    store_name = serializers.CharField(source='cake.store.store_name')
    cake_name = serializers.CharField(source='cake.name')
    cake_image = serializers.SerializerMethodField()

    class Meta:
        model = Order
        exclude = ['user', 'cake', 'store']

    def get_cake_image(self, obj):
        serializer = CakeImageSerializer(obj.cake.image.first())
        return serializer.data['image']

class ReviewSerializer(serializers.ModelSerializer):

    class Meta:
        model = Review
        fields = ('review', 'image', 'user')


class CartSerializer(serializers.ModelSerializer):

    store_name = serializers.CharField(source='cake.store.store_name')
    cake_name = serializers.CharField(source='cake.name')
    cake_image = serializers.SerializerMethodField()

    class Meta:
        model = Cart
        exclude = ['id', 'user', 'cake', 'store']

    def get_cake_image(self, obj):
        serializer = CakeImageSerializer(obj.cake.image.first())
        return serializer.data['image']
