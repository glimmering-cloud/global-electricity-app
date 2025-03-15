from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})

@app.route('/')
def index():
    return "Welcome to the Global Electricity Map!"

@app.route('/get_global_power_data')
def get_power_data():
    data = {
        'US': {'country': 'United States', 'power': 80},
        'IN': {'country': 'India', 'power': 60},
        'BR': {'country': 'Brazil', 'power': 40},
    }
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)