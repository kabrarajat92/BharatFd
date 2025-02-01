from django.test import TestCase
from .models import FAQ

class FAQTestCase(TestCase):
    def setUp(self):
        self.faq = FAQ.objects.create(question="What is Django?", answer="A Python web framework")

    def test_translation(self):
        translated_question = self.faq.get_translated_question("hi")
        self.assertIsNotNone(translated_question)
