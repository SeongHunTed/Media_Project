from django.shortcuts import render
from accounts.models import User
from stores.models import Store
from .serializers import *
from .models import *
import json, datetime
import calendar as cal
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

@api_view(['GET', 'POST', 'PUT'])
def calender(request):
    try:
        data = json.loads(request.body)
        
        user_email = data['user_email']
        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)

        week_day = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일']

        if request.method == 'POST' or request.method == 'PUT':

            year = int(data['year'])
            month = int(data['month'])
            date = int(data['date'])
            # target_date = data['date']

            closed = data['closed']
            max_order = data['max_order']

            target_date = datetime.datetime(year, month, date)

            day = week_day[target_date.weekday()]          # 해당 날의 요일 인덱스로 요일가져와서
            deadline = Day.objects.get(store=store, day=day).deadline # 해당 날의 deadline도 가져와서

            if Calender.objects.filter(store=store, date=target_date).exists():
                cal_instance = Calender.objects.get(store=store, date=target_date)
                cal_instance.deadline = deadline
                cal_instance.closed = closed
                cal_instance.max_order = max_order
                cal_instance.save()

            else:
                Calender.objects.create(store=store, date=target_date, deadline=deadline, closed=closed, max_order=max_order)

            return JsonResponse({'message' : 'SUCCESS'}, status=status.HTTP_201_CREATED)
            

        elif request.method == 'GET':
            today = datetime.date.today()
            this_month_last_day = cal.monthrange(today.year, today.month)[1]
            # next_month_last_day = cal.monthrange(today.year, today.month+1)[1]

            # week_day = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일']
            
            # if not Calender.objects.filter(store=store, date=today).exists():

            #     for i in range(today.day, this_month_last_day+1):
            #         date = today.replace(day=i)             # 해당 달의 모든 날짜를 가져오고
            #         day = week_day[date.weekday()]          # 해당 날의 요일 인덱스로 요일가져와서
            #         deadline = Day.objects.get(store=store, day=day).deadline # 해당 날의 deadline도 가져와서

            #         Calender.objects.create(date=date, store=store, deadline=deadline) # 해당 달의 모든 DB 생성

                # for i in range(1, next_month_last_day+1):
                #     date = today.replace(month=today.month+1, day=i)
                #     day = week_day[date.weekday()]
                #     deadline = Day.objects.get(store=store, day=day).deadline
                    
                #     Calender.objects.create(date=date, store=store, deadline=deadline) # 다음 달의 모든 DB 생성
                
                # return JsonResponse({'message' : 'SUCCESS'}, status=status.HTTP_201_CREATED)
            
            # else:
            calenders = Calender.objects.filter(store=store, date__range=[today.replace(day=1), today.replace(day=this_month_last_day)])

            serializer = CalenderSerializer(calenders, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK) 

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)
