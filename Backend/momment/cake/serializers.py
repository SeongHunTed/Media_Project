from rest_framework import serializers
from .models import *
from store.models import Store

class CakeSerializer(serializers.ModelSerializer):

    class Meta:
        model = Cake
        fields = '__all__'

class PriceSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Price
        fields = ['price_range']

class LocateSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Location
        fields = ['locate']

class FlavorSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Flavor
        fields = ['flavor']

# class DetailSerializer(serializers.Serializer):

#     price = Price.objects.all()
#     locate = Location.objects.all()
#     flavor = Flavor.objects.all()

#     price_serializer = PriceSeiralizer(price, many=True).data
#     locate_serializer = LocateSeiralizer(locate, many=True).data
#     flavor_serializer = FlavorSeiralizer(flavor, many=True).data
    


    