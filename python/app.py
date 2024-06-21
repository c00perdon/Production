# app.py

from flask import Flask, Response
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# Define a counter metric
REQUEST_COUNT = Counter('python_microservice_http_requests_total', 'Total HTTP Requests')

@app.route('/')
def hello():
    REQUEST_COUNT.inc()
    return "Hello, World!"

@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
