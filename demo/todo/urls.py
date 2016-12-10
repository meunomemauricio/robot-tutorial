from django.conf.urls import url

from . import views

app_name = 'todo'
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^insert/$', views.insert, name='insert'),
    url(r'^check/$', views.check, name='check'),
    url(r'^clear/$', views.clear, name='clear'),
]
