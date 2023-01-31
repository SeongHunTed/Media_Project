from . import views
from django.urls import path

urlpatterns = [
    path('day', views.day),
    path('calender', views.calender),
    path('order', views.order),
]