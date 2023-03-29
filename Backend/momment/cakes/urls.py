from . import views
from django.urls import path

urlpatterns = [
    path('', views.show),
    path('cake', views.cake),
    path('cake-image', views.cake_image),
    path('delete-detail', views.delete_detail),
    path('delete-option', views.delete_option),
    path('detail', views.detail),
    path('main/<int:page>', views.main),
    path('order', views.order),
    path('search/<int:page>', views.search),
    path('filter/<int:page>', views.filter)
]