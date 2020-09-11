from services_config import referrals_ip, referrals_port, users_port, users_ip

base_url_format=' http://{ip}:{port}'
#referrals
# referrals_ip, referrals_port = get_service("referrals")

referrals_base_url = base_url_format.format(ip=referrals_ip,port=referrals_port)
referrals_get_package_by_id=referrals_base_url + '/plans/id/{plan_id}'
referrals_get_all_packages=referrals_base_url + '/plans'
referrals_get_credits_and_codes = referrals_base_url + '/{user_id}?credits&promocodes'
referrals_post_successful_payment = referrals_base_url + '/successfulPayment'
referrals_get_promo_code_by_id=referrals_base_url + '/promo_codes/id/{code_id}'

#users
# users_ip, users_port = get_service("users")
users_base_url = base_url_format.format(ip=users_ip,port=users_port)
users_get_email = users_base_url + '/users/{user_id}/email'