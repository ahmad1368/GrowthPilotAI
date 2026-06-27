import os
from dotenv import load_dotenv
from anthropic import Anthropic

# ۱. بارگذاری متغیرهای محیطی از فایل .env
load_dotenv()

# ۲. ساخت کلاینت Anthropic (به طور خودکار کلید را از ANTHROPIC_API_KEY می‌خواند)
client = Anthropic()

# ۳. تعریف مدل مورد نظر
model = "claude-3-5-sonnet-20241022"  # نسخه استاندارد و دقیق مدل Sonnet

print("Claude API client initialized successfully!")