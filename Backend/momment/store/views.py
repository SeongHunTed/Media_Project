from .models import Store
from accounts.models import User
from .serializers import StoreSerializer

import json
from django.http import HttpResponse, JsonResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

@api_view(['POST', 'PUT'])
def update(request):
    try:
        data = json.loads(request.body)

        store_name      = data['store_name']
        store_intro     = data['store_intro']
        store_opentime  = data['store_opentime']
        store_closetime = data['store_closetime']
        store_digit     = data['store_digit']
        store_address   = data['store_address']
        user_email      = data['user_email']

        # user email을 이용하여 user_id 값 가져오기
        print(user_email)
        user = User.objects.get(email=user_email)

        if Store.objects.filter(user=user).exists():
            Store.objects.update(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                            store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user)
            return JsonResponse({'message' : 'UPDATE_SUCCESS'}, status=200)

        
        Store.objects.create(store_name=store_name, store_intro=store_intro, store_opentime=store_opentime,
                            store_closetime=store_closetime, store_digit=store_digit, store_address=store_address, user=user)


        return JsonResponse({'message' : "SUCCESS"}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

