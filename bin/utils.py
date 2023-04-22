import os
import yaml
import ipaddress


def getKeyValue(arg):
    key, value = arg.split("=")
    return {
        'key': key,
        'value': value
    }


def getNetwork(cidr):
    network = ipaddress.ip_network(cidr)
    return network


def readYml(dir):
    with open(dir, 'r', encoding="UTF-8") as file:
        return yaml.full_load(file)


def writeYml(dir, data):
    if os.path.isfile(dir):
        os.remove(dir)

    with open(dir, 'w', encoding="UTF-8") as file:
        yaml.dump(data, file)


def writeFile(dir, data):
    if os.path.isfile(dir):
        os.remove(dir)

    with open(dir, 'w', encoding="UTF-8") as file:
        file.write(data)
        file.close()