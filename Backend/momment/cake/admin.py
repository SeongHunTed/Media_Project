from django.contrib import admin
from .models import *
 
class CakeAdmin(admin.ModelAdmin):
    # 관리자 화면에 보여질 칼럼 지정
    list_display = ('name', 'store', 'price')
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()
 
admin.site.register(Cake, CakeAdmin)