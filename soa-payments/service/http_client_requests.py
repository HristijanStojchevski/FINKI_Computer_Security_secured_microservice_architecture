import requests

from endpoints_config import users_get_email
from service.token_decryptor import decode_token_and_get_user_id_from_token


def fetch_user_email(token: str):
    try:
        user_id = decode_token_and_get_user_id_from_token(token)
    except Exception:
        user_id=1
    URL = users_get_email.format(user_id = user_id)
    result = requests.get(url=URL)
    return result.json()





