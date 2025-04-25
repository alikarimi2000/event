# ── ۱. ایمیج پایه: پایتون ۳.۹ سبک
FROM python:3.9-slim

# ── ۲. تنظیم دایرکتوری کاری داخل کانتینر  ببب
WORKDIR /app

# ── ۳. کپی کل سورس‌کد و قالب‌ها
COPY . /app

# ── ۴. نصب وابستگی‌های سیستمی برای psycopg2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      gcc \
      libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# ── ۵. نصب پکیج‌های پایتونی مورد نیاز
RUN pip install --no-cache-dir \
      flask \
      flask-cors \
      pony \
      psycopg2-binary

# ── ۶. مستندسازی پورتی که Flask روش گوش می‌دهد
EXPOSE 5000

# ── ۷. فرمان پیش‌فرض برای اجرای اپ
CMD ["python", "app.py"]
