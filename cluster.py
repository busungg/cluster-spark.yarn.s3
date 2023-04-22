import os
import copy
import sys
import subprocess
sys.path.append('./bin')

import utils  # noqa: E402
import serviceManager  # noqa: E402

def up(argv):
    if len(argv) < 2:
        print("Set up each service count")
        sys.exit()

    networkConfigs = utils.readYml('./config/networks.yml')
    serviceConfigs = utils.readYml('./config/services.yml')
    volumeConfigs = utils.readYml('./config/volumes.yml')

    args = []
    try:
        for arg in argv[1:]:
            args.append(utils.getKeyValue(arg))
    except:
        print("arg is not in the correct format.")

    services = {}
    if len(args) > 0:
        for arg in args:
            serviceName = arg["key"]

            serviceNetworks = {}
            for networkName in serviceConfigs[serviceName]["networks"].keys():
                serviceNetworks[networkName] = networkConfigs[networkName]

            i = 1
            scale = int(arg["value"])
            while i <= scale:
                info = {}
                info["config"] = copy.deepcopy(serviceConfigs[serviceName])
                info["networks"] = serviceNetworks
                info["index"] = i
                services[f'{serviceName}{i}'] = serviceManager.getService(info)
                i += 1

    compose = {
        'version': '3.0'
    }
    compose['services'] = services
    compose["networks"] = networkConfigs
    compose["volumes"] = volumeConfigs
    utils.writeYml('./dist/docker-compose.yml', compose)

    workers = ""
    for serviceName in services.keys():
        if serviceName != 'master1':
            workers += (serviceName + "\n")
            
    for serviceName in services.keys():
        utils.writeFile(f"{services[serviceName]['build']['context']}/hadoop.etc.hadoop/workers", workers)
        utils.writeFile(f"{services[serviceName]['build']['context']}/spark.conf/workers", workers)

    try:
        os.system("docker volume create hadoop.ssh")
        os.system("docker volume create spark.ssh")
        os.system('docker build -t server ./dockerfile/server')
        os.system('docker build -t hadoop ./dockerfile/hadoop')
        os.system('docker build -t spark ./dockerfile/spark')
        build(argv)
        os.system(f"docker compose -p {argv[0]} -f ./dist/docker-compose.yml up -d")
        
        for serviceName in services.keys():
            serviceManager.removeServiceContext(f"{services[serviceName]['build']['context']}")

    except:
        print(f"faild docker compose {argv[0]} project up")

def build(argv):
    try:
        os.system(f"docker compose -p {argv[0]} -f ./dist/docker-compose.yml build --progress plain")
    except:
        print(f"faild docker compose {argv[0]} project build")


def down(argv):
    try:
        os.system(f"docker compose -p {argv[0]} down")
        os.system("docker volume rm hadoop.ssh")
        os.system("docker volume rm spark.ssh")
        os.system(
            "docker image rm -f $(docker image ls | grep cluster | awk '{print $3}')")
        os.system("docker image rm spark")
        os.system("docker image rm hadoop")
        os.system("docker image rm server")
    except:
        print(f"exception docker compose -p {argv[0]} down")


def help(argv):
    cmds = utils.readYml('./doc/cmd.yml')

    strFormat = '{:20s} {}'
    print(f"{'='*30}")
    print("Usage: python cluster.py COMMAND [options]\n")
    print("List of Main Commands: \n")
    for cmd in cmds:
        print(strFormat.format(cmd["name"], cmd["desc"]))
    print("\nList of Options: \n")
    print(f"{'='*30}")


functions = {
    "up": up,
    "build": build,
    "down": down,
    "help": help
}


def run(argv):
    if len(argv) < 2:
        help()

    serviceManager.setAbspath(os.path.dirname(os.path.abspath(__file__)))

    cmd = argv[1]
    functions[cmd](argv[2:])

    sys.exit()


run(sys.argv)
