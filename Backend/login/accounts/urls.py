from django.urls import path
from django.contrib.auth import views as auth_views
from accounts import views
from .views import UserCreateView

urlpatterns = [

    path('api/users/', UserCreateView.as_view(), name='user-create'),
    
    path('login/', auth_views.LoginView.as_view(template_name='회원가입(다트언어)페이지 링크'), name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('signup/', views.signup, name='signup'),

    path('google/login/', views.google_login, name='google_login'),
    path('google/callback/', views.google_callback, name='google_callback'),
    path('google/login/finish/', views.GoogleLogin.as_view(),
         name='google_login_todjango'),
    

]
