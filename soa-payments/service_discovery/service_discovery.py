import configparser

import netifaces
from consul import Consul, Check

from services_config import payments_service_name, payments_app_port, consul_port


def get_ip():
    config_parser = configparser.ConfigParser()
    config_file = "config.ini"
    config_parser.read(config_file)
    interface_name = config_parser['NETWORK']['interface']
    ip = netifaces.ifaddresses(interface_name)[netifaces.AF_INET][0]["addr"]
    return ip


def register_to_consul():
    consul = Consul(host="consul", port=consul_port)

    agent = consul.agent

    service = agent.service

    ip = get_ip()

    check = Check.http(f"http://{ip}:{payments_app_port}/", interval="10s", timeout="5s", deregister="1s")

    service.register(payments_service_name, service_id=payments_service_name, address=ip, port=payments_app_port, check=check)


def get_service(service_id):
    consul = Consul(host="consul", port=consul_port)

    agent = consul.agent

    service_list = agent.services()

    service_info = service_list[service_id]

    return service_info['Address'], service_info['Port']
