from flask import Flask, render_template, request, redirect, url_for
from mysql.connector import pooling
import bcrypt
import json
from google.cloud import pubsub_v1
from config import DATABASE_CONFIG

app = Flask(__name__)

# MySQL connection pooling for more availability
connection_pool = pooling.MySQLConnectionPool(
    pool_name="mypool",
    pool_size=5,  # Adjust based on traffic requirements
    **DATABASE_CONFIG
)

# Google Pub/Sub configurations
PROJECT_ID = "iac-infra-proj-prod"
TOPIC_ID = "user-submit-topic"
publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(PROJECT_ID, TOPIC_ID)

# Create a table to store user data if it doesn't exist
def initialize_database():
    create_table_query = """
        CREATE TABLE IF NOT EXISTS user (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255),
            email VARCHAR(255) UNIQUE NOT NULL,
            Address TEXT,
            phonenumber VARCHAR(15),
            password VARCHAR(255)
        )
    """
    try:
        with connection_pool.get_connection() as db:
            with db.cursor() as cursor:
                cursor.execute(create_table_query)
                db.commit()
    except Exception as e:
        print(f"Error initializing database: {e}")

# Initialize the database
initialize_database()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        address = request.form['address']
        phonenumber = request.form['phonenumber']

        # Hash the password before storing it
        password = request.form['password'].encode('utf-8')
        hashed_password = bcrypt.hashpw(password, bcrypt.gensalt())

        try:
            # Use connection pool to insert data
            with connection_pool.get_connection() as db:
                with db.cursor() as cursor:
                    insert_query = """
                        INSERT INTO user (name, email, Address, phonenumber, password)
                        VALUES (%s, %s, %s, %s, %s)
                    """
                    cursor.execute(insert_query, (name, email, address, phonenumber, hashed_password))
                    db.commit()

            # Publish message to Pub/Sub
            message_data = {"name": name, "email": email}
            try:
                future = publisher.publish(topic_path, json.dumps(message_data).encode("utf-8"))
                print(f"Published message to {TOPIC_ID} with ID: {future.result()}")
            except Exception as e:
                print(f"Failed to publish message: {e}")

            # Fetch the latest entry
            with connection_pool.get_connection() as db:
                with db.cursor() as cursor:
                    cursor.execute("SELECT * FROM user ORDER BY id DESC LIMIT 1")
                    data = cursor.fetchall()

            return render_template('submitteddata.html', data=data)

        except Exception as e:
            print(f"Error processing submission: {e}")
            return "An error occurred while processing your request.", 500

    return redirect(url_for('index'))

@app.route('/get-data', methods=['GET', 'POST'])
def get_data():
    if request.method == 'POST':
        input_id = request.form['input_id']
        try:
            with connection_pool.get_connection() as db:
                with db.cursor() as cursor:
                    select_query = "SELECT * FROM user WHERE id = %s"
                    cursor.execute(select_query, (input_id,))
                    data = cursor.fetchall()
            return render_template('data.html', data=data, input_id=input_id)
        except Exception as e:
            print(f"Error retrieving data: {e}")
            return "An error occurred while retrieving data.", 500

    return render_template('get_data.html')

@app.route('/delete/<int:id>', methods=['GET', 'POST'])
def delete_data(id):
    if request.method == 'POST':
        try:
            with connection_pool.get_connection() as db:
                with db.cursor() as cursor:
                    delete_query = "DELETE FROM user WHERE id = %s"
                    cursor.execute(delete_query, (id,))
                    db.commit()
            return redirect(url_for('get_data'))
        except Exception as e:
            print(f"Error deleting data: {e}")
            return "An error occurred while deleting the data.", 500
    return render_template('delete.html', id=id)

if __name__ == '__main__':
    app.run(debug=True, port=8080, host='0.0.0.0')