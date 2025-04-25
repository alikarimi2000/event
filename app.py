from flask import Flask, request, render_template, jsonify
from pony.orm import Database, Required, db_session
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# database connection
db = Database()
db.bind(
    provider='postgres',
    user='postgres',
    password='HYRQHMQHtCcQDV2NXhcC',
    host='event.genx-pishehkav-data.svc',
    port=5432,
    database='postgres'
)

class Registration(db.Entity):
    name = Required(str)
    email = Required(str)
    phone = Required(str)
    event = Required(str)

db.generate_mapping(create_tables=True)

@app.route('/')
def index():
    return render_template('form.html')

@app.route('/register', methods=['POST'])
@db_session
def register():
    name = request.form.get('name', '').strip()
    email = request.form.get('email', '').strip()
    phone = request.form.get('phone', '').strip()
    event = request.form.get('event', '').strip()

    # simple server-side validation
    if not all([name, email, phone, event]):
        return jsonify({'status': 'error', 'message': 'All fields are required.'}), 400

    Registration(name=name, email=email, phone=phone, event=event)
    return jsonify({'status': 'success', 'message': 'Registration completed.'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)