#!/bin/bash
# ================================
# SETUP SCRIPT FOR DJANGO PROJECT
# ================================

# Step 1: Create/Activate Virtual Environment
if [ -d ".venv" ]; then
    echo "Activating existing virtual environment..."
    # For Windows (PowerShell or CMD), use: .venv\Scripts\activate
    source .venv/bin/activate || source .venv/Scripts/activate
else
    echo "Creating virtual environment..."
    python -m venv .venv
    # Activate it
    source .venv/bin/activate || source .venv/Scripts/activate
fi

# Step 2: Install required packages
echo "Installing dependencies..."
pip install django mysqlclient django-ckeditor djangorestframework

# Step 3: Create Django Project (if not already created)
# Uncomment the next two lines if you haven't already created a project
# django-admin startproject faq_project
# cd faq_project

# (If your project already exists, ensure you’re in the project root directory.)

# Step 4: Configure settings.py
# -----------------------------------
# In faq_project/settings.py, ensure you have these settings:
#
# INSTALLED_APPS = [
#     'django.contrib.admin',
#     'django.contrib.auth',
#     'django.contrib.contenttypes',
#     'django.contrib.sessions',
#     'django.contrib.messages',
#     'django.contrib.staticfiles',
#     'rest_framework',          # Added for DRF
#     'ckeditor',                # Added for CKEditor (if needed)
#     'faq',                     # Your app for FAQs
# ]
#
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.mysql',
#         'NAME': 'faq_db',         # Replace with your MySQL database name
#         'USER': 'root',           # Replace with your MySQL username
#         'PASSWORD': 'password',   # Replace with your MySQL password
#         'HOST': 'localhost',
#         'PORT': '3306',
#     }
# }
#
# Also ensure you have configured STATIC_URL and any other settings you require.
# -----------------------------------

# Step 5: Create your FAQ app (if not already created)
echo "Creating the 'faq' app (if not already created)..."
python manage.py startapp faq

# Step 6: Create/Update files for your FAQ API
# -----------------------------------
# Create or update faq/models.py with the FAQ model:
cat > faq/models.py << 'EOF'
from django.db import models

class FAQ(models.Model):
    question = models.TextField()
    answer = models.TextField()
    language = models.CharField(max_length=10, default='en')

    def __str__(self):
        return self.question
EOF

# Create or update faq/serializers.py with the FAQ serializer:
cat > faq/serializers.py << 'EOF'
from rest_framework import serializers
from .models import FAQ

class FAQSerializer(serializers.ModelSerializer):
    class Meta:
        model = FAQ
        fields = '__all__'
EOF

# Create or update faq/views.py with the FAQ API view:
cat > faq/views.py << 'EOF'
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import FAQ
from .serializers import FAQSerializer

class FAQListView(APIView):
    def get(self, request):
        # Retrieve 'lang' parameter; default is 'en'
        lang = request.GET.get('lang', 'en')
        # Optionally, filter FAQs by language if needed:
        faqs = FAQ.objects.filter(language=lang)
        serializer = FAQSerializer(faqs, many=True)
        return Response(serializer.data)
EOF

# Create or update faq/urls.py to register the API endpoint:
mkdir -p faq
cat > faq/urls.py << 'EOF'
from django.urls import path
from .views import FAQListView

urlpatterns = [
    path('', FAQListView.as_view(), name='faq-list'),
]
EOF

# Step 7: Update the project-level urls.py to include the FAQ API routes
# Edit faq_project/urls.py (this file should already exist)
# Append or modify the content as follows:
cat > faq_project/urls.py << 'EOF'
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/faqs/', include('faq.urls')),  # This maps /api/faqs/ to faq.urls
]
EOF

# Step 8: Make migrations and migrate the database
echo "Making migrations..."
python manage.py makemigrations
echo "Migrating database..."
python manage.py migrate

# (Optional) Step 9: Create a superuser for the admin panel
echo "Creating a superuser (follow the prompts)..."
python manage.py createsuperuser

# Step 10: Run the development server
echo "Starting Django development server..."
python manage.py runserver

# End of script
