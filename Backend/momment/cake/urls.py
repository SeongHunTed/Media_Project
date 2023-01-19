from . import views
from django.urls import path

urlpatterns = [
    path('update/', views.update),
    path('delete_detail/', views.delete_detail),
    path('delete_option/', views.delete_option),
    path('delete_all/', views.delete_all),
]