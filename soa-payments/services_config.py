import os

payments_app_port= int(os.getenv('PAYMENTS_PORT'))
payments_service_name='payments'

users_ip = os.getenv('USERS_IP')
users_port = os.getenv('USERS_PORT')

referrals_ip = os.getenv('REFERRALS_IP')
referrals_port = os.getenv('REFERRALS_PORT')

consul_port = os.getenv('CONSUL_PORT')