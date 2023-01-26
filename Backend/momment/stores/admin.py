from django.contrib import admin
from .models import Store
 
class StoreAdmin(admin.ModelAdmin):
    # 관리자 화면에 보여질 칼럼 지정
    list_display = ('store_name', 'store_digit', 'user')
    search_fields = ('user', 'store_name')
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ('id',)
 
admin.site.register(Store, StoreAdmin)