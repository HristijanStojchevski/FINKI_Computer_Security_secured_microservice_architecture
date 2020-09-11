import jwt
# public key in case we need to verify the token
public_key = "b'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs2iY+UNfz035EspzTZUeSai+FbBQC487BLsWC/BA+d5b1UFVs0k1erXnqrFBWjKzgn10r3fMfPlPn8ffK8iEuvBEoJ5vnRaHRqjhIi1DZ+h1o5sC9qhty0p5k+Nu9i0rV/CpY6PkAQw/e7kXBMWhK8zM/TAsA0GQUOaZDm/4WeNUq2roMAX+fAJZfMFiI2/WRvBQKcTY1SB6wJhC9c5QhBgWs83XR9EGP6BxyzvJMroR0kMyb+B7ITWbzpKXuUWbhsxRWm0Mz2nwHo9jsREC03wN0CnD+vocCnKjLv/4Bqy9igwKBT2bpAssR0Y7p3v1QZmSO3D4OxUhhkoWBZBCyQIDAQAB'"

def decode_token(token: str):
    decoded_token = jwt.decode(token)
    return decoded_token

def decode_token_and_get_user_id_from_token(token: str):
    decoded_token = decode_token(token)
    # we still dont know how the jwt will look
    return decoded_token["id"]

