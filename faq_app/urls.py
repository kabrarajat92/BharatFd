from django.urls import path
from . import views

urlpatterns = [
    path('', views.faq_home, name='faq_home'),
    path('create/', views.faq_create, name='faq_create'),
]
