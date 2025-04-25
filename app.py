from flask import Flask, request, jsonify
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# ---------- اتصال به دیتابیس PostgreSQL ----------
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:HYRQHMQHtCcQDV2NXhcC@81.12.30.45:30328/postgres'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# ---------- مدل دیتابیس ----------
db = SQLAlchemy(app)

class Registration(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(20), nullable=False)
    event = db.Column(db.String(50), nullable=False)

# ---------- ساخت جدول‌ها ----------
with app.app_context():
    db.create_all()

# ---------- صفحه اصلی ----------
@app.route('/')
def home():
    return render_template('form.html')  # Serve the HTML page

# ---------- API ثبت‌نام ----------
@app.route('/register', methods=['POST'])
def register():
    name = request.form.get('name')
    email = request.form.get('email')
    phone = request.form.get('phone')
    event = request.form.get('event')

    if not name or not email or not phone or not event:
        return jsonify({'error': 'Invalid input'}), 400

    new_registration = Registration(
        name=name,
        email=email,
        phone=phone,
        event=event
    )
    db.session.add(new_registration)
    db.session.commit()

    return jsonify({'message': 'Registration successful!'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)