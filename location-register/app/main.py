import json
import logging
import socket
import os
from typing import Dict

import jwt
from fastapi import FastAPI, Header, Form, Body
from keycloak import KeycloakAdmin, KeycloakOpenID
from fastapi.security.utils import get_authorization_scheme_param


app = FastAPI(docs_url='/docs', openapi_url='/openapi.json')

#class Offer(BaseModel):
#	def __init__(self, name, description, price):
#	name: str
#	description: Optional[str] = None
#	price: float

@app.get("/")
def root():
	return {"Hello": "World"}

@app.get("/prices/")
async def share_offers(Authorization: str = Header(None)) -> Dict:
	#Check if he is logged in
	scheme, credentials = get_authorization_scheme_param(Authorization)
	if credentials:
		public_key = "b'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs2iY+UNfz035EspzTZUeSai+FbBQC487BLsWC/BA+d5b1UFVs0k1erXnqrFBWjKzgn10r3fMfPlPn8ffK8iEuvBEoJ5vnRaHRqjhIi1DZ+h1o5sC9qhty0p5k+Nu9i0rV/CpY6PkAQw/e7kXBMWhK8zM/TAsA0GQUOaZDm/4WeNUq2roMAX+fAJZfMFiI2/WRvBQKcTY1SB6wJhC9c5QhBgWs83XR9EGP6BxyzvJMroR0kMyb+B7ITWbzpKXuUWbhsxRWm0Mz2nwHo9jsREC03wN0CnD+vocCnKjLv/4Bqy9igwKBT2bpAssR0Y7p3v1QZmSO3D4OxUhhkoWBZBCyQIDAQAB'"
		
		decoded = jwt.decode(
			credentials, key=public_key, verify=False
		)
		# check if User has role Activist
		if "Activist" in decoded.realm_access.roles:
			return {"offers":{"One location":"20$","5 Locations":"80$","10 Locations":"150"}}
		else:
			return {"offers":{"One location": "20$"}}
	else:
		return {"message": "You're not logged in!"}
		