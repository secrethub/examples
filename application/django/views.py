from django.http import HttpResponse
from os import getenv

def index(request):
    if not (getenv('DEMO_USERNAME') and getenv('DEMO_PASSWORD')):
        content = 'not all variables are set'
        status = 500
    else:
        content = 'Welcome ' + str(getenv('DEMO_USERNAME'))
        status = 200
    return HttpResponse(content,status=status)
