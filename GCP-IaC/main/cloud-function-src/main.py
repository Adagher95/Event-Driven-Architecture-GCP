import base64
import json
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

SENDGRID_API_KEY = "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"

def send_email(event, context):
    # Decode the Pub/Sub message
    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    data = json.loads(pubsub_message)

    # Extract user data
    name = data.get("name")
    email = data.get("email")

    # Send email using SendGrid
    message = Mail(
        from_email="ahmad_gcp@ahmadd71.com",
        to_emails=email,
        subject="Welcome to Our App!",
        html_content=f"Hello {name},<br><br>Thank you for signing up! We're excited to have you on board."
    )

    try:
        sg = SendGridAPIClient(SENDGRID_API_KEY)
        response = sg.send(message)
        print(f"Email sent to {email} with status code {response.status_code}")
    except Exception as e:
        print(f"Error sending email: {e}")
