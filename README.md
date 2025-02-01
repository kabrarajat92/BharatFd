# BharatFd - FAQ Management System

## Project Overview

BharatFd is a multilingual FAQ management system built with Django. This project provides a comprehensive solution for managing frequently asked questions (FAQs) with support for multiple languages, rich text editor integration, and a RESTful API for querying FAQs. The project also implements caching using Redis for optimized performance and includes automated translation support using the Google Translate API.
![image](https://github.com/user-attachments/assets/5a29b01b-6311-4f14-8a18-f11e6c201ce1)

![image](https://github.com/user-attachments/assets/116202af-119a-413e-8085-165ec521b32b)



## Features

- **Django-based FAQ Management**: A model is created to store FAQs, including the question, answer, and language-specific translations.
- **WYSIWYG Editor Integration**: Using `django-ckeditor`, users can easily format answers with rich text.
- **Multi-language Support**: The system automatically translates FAQs into multiple languages (e.g., Hindi, Bengali) using the Google Translate API.
- **REST API**: A REST API allows fetching FAQs in different languages, supporting dynamic language selection via query parameters (`?lang=xx`).
- **Caching**: Redis caching mechanism is implemented for storing translations, improving response time.
- **Admin Interface**: User-friendly Django admin interface for managing FAQs.
- **Unit Tests**: Tests are written using pytest to ensure the correctness of models and API endpoints.
- **Docker Support**: The project can be run inside a Docker container with the help of a Dockerfile and docker-compose configuration.

## Installation

Follow the steps below to get the project up and running on your local machine.

### Prerequisites

- Python 3.x
- Docker (for containerization)
- Redis (for caching)

### Step 1: Clone the Repository

```bash
git clone https://github.com/kabrarajat92/bharatfd.git
cd bharatfd
```

### Step 2: Install Dependencies

- You can use a virtual environment to install the dependencies.
- If you're on Unix-based systems (Linux/macOS), run:
```bash
python -m venv .venv
source .venv/bin/activate  # For Unix-based OS
```

- For Windows, use:
```
.venv\Scripts\activate  # For Windows
```

- Install the required dependencies
```
pip install -r requirements.txt
```

- Alternatively, you can use Docker to run the application
- Docker will automatically install the dependencies based on the Dockerfile

### Step 3: Set Up the Database

- Run the following commands to set up the database:
```
python manage.py migrate
```

### Step 4: Run the Application

- You can run the application using Docker:
```
docker-compose up --build
```
-This will start the application on http://localhost:8000/
-If you want to run the application without Docker, use:
```
python manage.py runserver
````

### Step 5: Test the Application

- Visit http://localhost:8000/faq/ to view the FAQ page in your browser
- Use the API to fetch FAQs in different languages:
- Fetch FAQs in English (default):
```
curl http://localhost:8000/api/faqs/
```
- Fetch FAQs in Hindi:
```
curl http://localhost:8000/api/faqs/?lang=hi
```
- Fetch FAQs in Bengali:
```
curl http://localhost:8000/api/faqs/?lang=bn
```

![image](https://github.com/user-attachments/assets/8b7b6af9-1641-4a74-8d07-4460572bb897)

### Step 6: Docker Usage
If you'd like to use Docker to isolate the environment, you can follow these steps:
- Build and Start Containers
```
docker-compose up --build
```
### Step 7: Stop the Containers
```
docker-compose down
```
### Step 8: Redis Caching
- This project uses Redis to cache translations for faster access. Make sure Redis is running.
- You can use Docker to run Redis as a container:
```
docker-compose up redis
```
### Step 9: Testing

- The project includes unit tests written using pytest to ensure the correctness of the models and API responses.
- Run the following command to execute the tests:
```
pytest
```
### Step 10: Git and Version Control
The project follows conventional Git commit messages. Below are some of the commit message conventions:

- feat: Add a new feature
- fix: Fix a bug
- docs: Update the documentation

Here are the steps to commit and push your changes:
#### 1. Stage your changes:
```
git add .
```
#### 2. Commit your changes with a meaningful message:
```
git commit -m "feat: add multilingual FAQ support"
```
#### 3. Push your changes to GitHub:
```
git push origin main
```
### Step 11: Deployment (Optional)
- You can deploy the application to platforms like Heroku or AWS. Here’s a guide to deploying it on Heroku:

#### 1. Log in to Heroku using the CLI:
```
heroku login
```
#### 2. Create a new Heroku app:
```
heroku create
```
#### 3. Push the code to Heroku:
```
git push heroku main
```
#### 4. Set up any environment variables like database credentials or API keys:
```
heroku config:set YOUR_ENV_VAR=value
```
### Step 12: Contributing

- If you’d like to contribute to the project, follow these steps:

#### 1. Fork the repository on GitHub.
#### 2. Create a new branch for your feature:
```
git checkout -b feature-name
```
#### 3. Make your changes.
#### 4. Commit your changes:
```
git commit -m "feat: add new feature"
```
#### 5. Push your branch to GitHub:
```
git push origin feature-name
```
#### 6. Create a pull request on GitHub.

#### We welcome contributions to make this project better!

