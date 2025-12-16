"""
WSGI config for dolce_backend project.
"""
import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dolce_backend.settings')

application = get_wsgi_application()

