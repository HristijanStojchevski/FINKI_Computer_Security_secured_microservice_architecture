import os
import smtplib
import ssl
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from creds import mail_password, mail_email


def send_receipt(content, receiver_email=mail_email):
    print('sending mail')
    send_mail(content=content,
              content_type='html',
              receiver_email=receiver_email,
              subject="Your receipt from SOA Payments")


def send_mail(content, content_type, receiver_email, subject):
    sender_email = mail_email
    sender_password = mail_password

    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = receiver_email

    # Turn these into plain/html MIMEText objects
    html_content = MIMEText(content, content_type)

    # Add HTML/plain-text parts to MIMEMultipart message
    # The email client will try to render the last part first
    message.attach(html_content)

    # Create secure connection with server and send email
    context = ssl.create_default_context()
    gmail_port = int(os.getenv('SMTP_PORT'))
    with smtplib.SMTP_SSL("smtp.gmail.com", gmail_port, context=context) as server:
        server.login(sender_email, sender_password)
        server.sendmail(
            sender_email, receiver_email, message.as_string()
        )
