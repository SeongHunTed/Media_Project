from django.shortcuts import render
from accounts.models import User
from stores.models import Store
from .serializers import *
from .models import *
import json
from rest_framework.renderers import JSONRenderer
from django.http import JsonResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

@api_view(['POST', 'PUT', 'GET'])
def day(request):
    try:
        data = json.loads(request.body)
        
        user_email = data['user_email']
        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)

        if request.method == 'POST' or request.method == 'PUT':
            
            options = data['options'].keys()
            for option in options:
                day = data['options'][option]['day']
                deadline = data['options'][option]['deadline']

                if Day.objects.filter(day=day, store=store).exists():
                    day_instance = Day.objects.get(day=day, store=store)
                    day_instance.deadline = deadline
                    day_instance.save()
                else:
                    Day.objects.create(day=day, store=store, deadline=deadline)
            
            return JsonResponse({'message' : 'SUCCESS'}, status=status.HTTP_201_CREATED)

        elif request.method == 'GET':

            if Day.objects.filter(store=store).exists():
                days = Day.objects.filter(store=store)                
                serializer = DaySerializer(days, many=True)
            else:
                # 최초 등록하는 경우
                # cake, store 뭔가 다 논리를 적용시키지 않은듯
                # GET 관련 이 논리 로직 다 적용해야할듯
                return JsonResponse({'message' : 'NONE'}, status=status.HTTP_200_OK)

            return Response(serializer.data, status=status.HTTP_200_OK)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)