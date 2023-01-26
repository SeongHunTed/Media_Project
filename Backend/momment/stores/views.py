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
        data = json.loads(request.body)
        user_email = data['user_email']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)

        serializer = StoreSerializer(store)

        return Response(serializer.data, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@api_view(['POST', 'PUT', 'DELETE'])
def store(request):
    try:
        if request.method == 'POST' or request.method == 'PUT':
            
            data = json.loads(request.body)

            store_name = data['store_name']
            store_intro = data['store_intro']
            store_opentime = data['store_opentime']
            store_closetime = data['store_closetime']
            store_digit= data['store_digit']
            store_address = data['store_address']
            user_email = data['user_email']

            # user email을 이용하여 user_id 값 가져오기
            user = User.objects.get(email=user_email)

            if Store.objects.filter(user=user).exists():
                Store.objects.update(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                                store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user)
                return JsonResponse({'message' : 'UPDATE_SUCCESS'}, status=202)
            
            Store.objects.create(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                                store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user)

            return JsonResponse({'message' : "SUCCESS"}, status=201)

        elif request.method == 'DELETE':

            data = json.loads(request.body)

            user_email = data['user_email']
            user = User.objects.get(email=user_email)
            store = Store.objects.get(user=user)
            
            store.delete()

            return JsonResponse({'message' : "DELETE SUCCESS"}, status=202)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)
