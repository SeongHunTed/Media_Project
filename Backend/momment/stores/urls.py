from . import views
from django.urls import path

urlpatterns = [
    path('', views.show),
    path('store', views.store),
]