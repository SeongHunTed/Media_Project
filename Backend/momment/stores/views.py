from .models import Store
from accounts.models import User
from .serializers import StoreSerializer

import json
from django.http import HttpResponse, JsonResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

@api_view(['GET'])
def show(request):
    try:
        data = request.data
        user_email = data['user_email']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)
        store = Store.objects.all()

        serializer = StoreSerializer(store, many=True, context={'request': request})

        return Response(serializer.data, status=200)

    except KeyError:
        return Response({'message' : 'KEY_ERROR'}, status=400)


@api_view(['POST', 'PUT', 'DELETE'])
def store(request):
    try:
        if request.method == 'POST' or request.method == 'PUT':
            
            data = request.data
            images_data = request.FILES.getlist('images')
            user_email = data['user_email']
            store_name = data['store_name']
            store_intro = data['store_intro']
            store_opentime = data['store_opentime']
            store_closetime = data['store_closetime']
            store_digit= data['store_digit']
            store_address = data['store_address']

            image1 = images_data[0]
            image2 = images_data[1]
            image3 = images_data[2]
            image4 = images_data[3]
            image5 = images_data[4]

            user = User.objects.get(email=user_email)

            if Store.objects.filter(user=user).exists():
                store = Store.objects.update(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                        store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user)
                store.save()
                    
                return Response(status=202)
            else:
                store = Store.objects.create(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                                store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user, image1=image1, image2=image2, image3=image3, image4=image4, image5=image5)
                
                return Response(status=status.HTTP_201_CREATED)

        elif request.method == 'DELETE':

            data = json.loads(request.body)

            user_email = data['user_email']
            user = User.objects.get(email=user_email)
            store = Store.objects.get(user=user)
            
            store.delete()

            return JsonResponse({'message' : "DELETE SUCCESS"}, status=202)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)