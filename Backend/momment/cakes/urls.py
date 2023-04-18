from . import views
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.main_menu_cake_list),
    path('cake-tap/<int:page>', views.cake_list_filterd),
    path('cake', views.cake),
    path('cake-image', views.cake_image),
    path('cake-info-image', views.cake_pop_up_set),
    path('cake-popup/', views.cake_pop_up),
    path('delete-detail', views.delete_detail),
    path('delete-option', views.delete_option),
    path('detail', views.detail),
    path('main/<int:page>', views.main),
    path('order', views.order),
    path('search/<int:page>', views.search),
    path('filter/<int:page>', views.filter)
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)