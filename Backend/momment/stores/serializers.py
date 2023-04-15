from .models import Store
from django.conf import settings

from rest_framework import serializers


class StoreSerializer(serializers.ModelSerializer):

    image1 = serializers.ImageField(use_url = False)

    class Meta:
        model = Store
        exclude = ('image2', 'image3', 'image4', 'image5', 'user', 'id')

class DetailStoreSerializer(serializers.ModelSerializer):

    image1 = serializers.ImageField(use_url = False)
    image2 = serializers.ImageField(use_url = False)
    image3 = serializers.ImageField(use_url = False)
    image4 = serializers.ImageField(use_url = False)
    image5 = serializers.ImageField(use_url = False)

    class Meta:
        model = Store
        exclude = ('user', 'id')
