from . import views
from django.urls import path

urlpatterns = [
    path('update/', views.update),
    path('delete_all/', views.delete_all),
]