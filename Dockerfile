# از یک ایمیج رسمی پایتون استفاده می‌کنیم
FROM python:3.11-slim

# تنظیم دایرکتوری کاری
WORKDIR /app

# کپی کردن فایل‌ها به داخل کانتینر
COPY . /app

# نصب وابستگی‌ها
RUN pip install --no-cache-dir -r requirements.txt

# باز کردن پورت
EXPOSE 5000

# اجرای اپلیکیشن
CMD ["python", "app.py"]

