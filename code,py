import psycopg2
import pandas as pd
import numpy as np
from flask import Flask, jsonify

# Database settings
DATABASE = "dbname=analytics user=myuser password=mypassword"

# Initialize Flask app
app = Flask(__name__)

def init_db():
    conn = psycopg2.connect(DATABASE)
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS sensor_data (
            id SERIAL PRIMARY KEY,
            timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            value NUMERIC NOT NULL
        );
    """)
    conn.commit()
    cur.close()
    conn.close()

def collect_data():
    # Simulate data collection
    data = pd.DataFrame({
        'timestamp': pd.to_datetime('now'),
        'value': np.random.rand()
    })
    return data

def store_data(data):
    conn = psycopg2.connect(DATABASE)
    cur = conn.cursor()
    psycopg2.extras.execute_batch(cur,
        "INSERT INTO sensor_data (timestamp, value) VALUES (%s, %s)",
        data.values)
    conn.commit()
    cur.close()
    conn.close()

@app.route('/')
def show_data():
    conn = psycopg2.connect(DATABASE)
    cur = conn.cursor()
    cur.execute("SELECT * FROM sensor_data;")
    data = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(data)

@app.route('/average')
def average_value():
    conn = psycopg2.connect(DATABASE)
    cur = conn.cursor()
    cur.execute("SELECT AVG(value) FROM sensor_data;")
    avg = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify({"average": avg[0]})

if __name__ == '__main__':
    init_db()
    data = collect_data()
    store_data(data)
    app.run(debug=True)
