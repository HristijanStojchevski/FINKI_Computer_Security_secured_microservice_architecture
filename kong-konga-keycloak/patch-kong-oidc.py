import requests
import socket

KONG_OIDC_PLUGIN_URL = "http://localhost:8001/plugins/de00c863-34d3-48d0-9541-8f77cd0f3a90"
LOCAL_IP = '192.168.37.138'

payload = (
        f"config.introspection_endpoint=http://{LOCAL_IP}:8180/auth/realms/test/protocol/openid-connect/token/introspect"
        f"&config.discovery=http://{LOCAL_IP}:8180/auth/realms/test/.well-known/openid-configuration"
    )
headers = {"Content-Type": "application/x-www-form-urlencoded"}
requests.request(
    "PATCH", KONG_OIDC_PLUGIN_URL, data=payload, headers=headers
)
