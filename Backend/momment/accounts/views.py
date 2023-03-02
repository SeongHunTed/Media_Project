# 커스텀 로그인
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from accounts.models import User, Account
import requests, json, re
from django.contrib.auth.hashers import check_password
from rest_framework import status
from json.decoder import JSONDecodeError
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from django.contrib import auth
from rest_framework.decorators import api_view
from .serializers import *


# 카카오 로그인
from rest_framework.views import APIView, View
from django.conf import settings
from django.shortcuts import redirect
from rest_framework.response import Response


BASE_URL = "http://127.0.0.1:8000/" 
KAKAO_CALLBACK_URI = "http://127.0.0.1:8000/accounts/kakao/callback/"
kakao_token_uri = "https://kauth.kakao.com/oauth/token"
kakao_profile_uri = "https://kapi.kakao.com/v2/user/me"

@api_view(['POST', 'PUT'])
def signup(request):
    try:
        data = json.loads(request.body)

        email = data['email']
        if request.method == 'POST':

            name = data['name']
            digit = data['digit']
            birth = data['birth']
            address = data['address']

            password = data['password']

            if User.objects.filter(email=email).exists():
                return JsonResponse({'message' : 'ALREADY_EXIST'}, status = 400)

            regex_email    = '^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9_-]+\.[a-zA-Z0-9-.]+$'
            regex_password = '\S{8,25}'
            if not re.match(regex_email, email):
                return JsonResponse({'message' : 'INVALID_EMAIL'}, status = 400)
            if not re.match(regex_password, password):
                return JsonResponse({'message' : 'INVALID_PASSWORD'}, status = 400)

            user = User.objects.create_user(email=email, password=password, name=name, digit=digit, birth=birth, address=address)

            token = Token.objects.create(user=user)
            return JsonResponse({'message' : 'SUCCESS', 'token' : token.key}, status=201)
        
        elif request.method == 'PUT':
            
            user = User.objects.get(email=email)
            serializer = UserSerializer(user, data=data)
            if serializer.is_valid():
                serializer.save()

            return Response(serializer.data)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@api_view(['POST'])
def login(request):
    try:
        data = json.loads(request.body)
        print(data)
        email = data['email']
        password = data['password']
        user = User.objects.get(email=email)

        if not check_password(password, user.password):
            return JsonResponse({'message' : 'WRONG_PASSWORD'})
        
        token = Token.objects.get(user=user)
        is_seller = user.is_staff
        
        return JsonResponse({'message' : 'LOGIN_SUCCESS', 'token' : token.key, 'is_seller' : is_seller}, status=200)
    except:
        return JsonResponse({'message' : 'LOGIN_FAILED'})

@api_view(['POST'])
def logout(request):
    auth.logout(request)
    return redirect(BASE_URL)

class KakaoView(View):
    def get(self, request):
        rest_api_key = getattr(settings, 'KAKAO_REST_API_KEY')
        print("working")
        return redirect(
        f"https://kauth.kakao.com/oauth/authorize?response_type=code&client_id={rest_api_key}&redirect_uri={KAKAO_CALLBACK_URI}")

class KakaoCallBackView(View):
    
    def get(self, request):
        code = request.GET['code']
        
        # access_token 발급 요청
        if not code:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        client_key = getattr(settings, 'CLIENT_KEY')
        rest_api_key = getattr(settings, 'KAKAO_REST_API_KEY')
        data = {
            "grant_type"        :"authorization_code",
            "client_id"         :rest_api_key,
            "redirection_uri"   :KAKAO_CALLBACK_URI,
            "client_secret"        :client_key,
            "code"              :request.GET["code"]
        }

        token_headers = {
            'Content-type': 'application/x-www-form-urlencoded;charset=utf-8'
        }
        token_res = requests.post(kakao_token_uri, data=data, headers=token_headers)

        token_json = token_res.json()
        access_token = token_json.get('access_token')

        if not access_token:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        access_token = f"Bearer {access_token}"  # 'Bearer ' 마지막 띄어쓰기 필수

        # kakao 회원정보 요청
        auth_headers = {
            "Authorization": access_token,
            "Content-type": "application/x-www-form-urlencoded;charset=utf-8",
        }
        user_info_res = requests.get(kakao_profile_uri, headers=auth_headers)
        user_info_json = user_info_res.json()

        social_type = 'kakao'
        social_id = f"{social_type}_{user_info_json.get('id')}"

        kakao_account = user_info_json.get('kakao_account')
        if not kakao_account:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        user_email = kakao_account.get('email')

        print(user_email)
        '''
        # 회원가입 및 로그인 처리 알고리즘 
        '''

        print(user_info_json)



        # 테스트 값 확인용
        res = {
            'social_type': social_type,
            'social_id': social_id,
            'user_email': user_email,
        }
        response = Response(status=status.HTTP_200_OK)
        response.data = res
        
        return redirect(BASE_URL)
