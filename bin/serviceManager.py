import re
import utils
import os
import shutil
import xml.etree.ElementTree as ET

abspath = ''


def setAbspath(path):
    global abspath
    abspath = path


def getService(info):
    config = info['config']
    index = info['index']

    networks = {}
    for key in info['networks'].keys():
        networks[key] = utils.getNetwork(
            info['networks'][key]['ipam']['config'][0]['subnet'])

    setServiceNetwork(config['networks'], networks, index)
    setServiceHostName(config, index)
    setServiceContainerName(config, index)
    setServicePorts(config, index)
    setServiceContext(config, index)

    return config


def setServiceNetwork(networkConfigs, networks, index):

    for key in networkConfigs.keys():
        networkConfig = networkConfigs[key]
        ipv4 = networkConfig['ipv4_address']

        if len(re.findall('\{net\}', ipv4)) > 0:
            ipIndex = len(re.findall('\.', ipv4))
            net = '.'.join(
                f"{networks[key].network_address}".split('.')[:-ipIndex])
            ipv4 = ipv4.replace('{net}', net)

        ipMatch = re.match('[\d\.]*\.\{(\d*)\:\}', ipv4)
        if ipMatch:
            ipv4 = re.sub(
                '\{\d*\:\}', f'{int(ipMatch.group(1)) + index - 1}', ipv4)

        networkConfig['ipv4_address'] = ipv4


def setServiceHostName(serviceConfig, index):
    hostname = serviceConfig['hostname']
    hostnameMatch = re.match('.*\{(\d*)\:\}', hostname)
    if hostnameMatch:
        hostname = re.sub(
            '\{\d*\:\}', f'{int(hostnameMatch.group(1)) + index - 1}', hostname)
        serviceConfig['hostname'] = hostname


def setServiceContainerName(serviceConfig, index):
    containerName = serviceConfig['container_name']
    containerNameMatch = re.match('.*\{(\d*)\:\}', containerName)
    if containerNameMatch:
        containerName = re.sub(
            '\{\d*\:\}', f'{int(containerNameMatch.group(1)) + index - 1}', containerName)
        serviceConfig['container_name'] = containerName


def setServicePorts(serviceConfig, index):
    ports = serviceConfig['ports']

    for idx, port in enumerate(ports):
        portMatch = re.match('\{(\d*)\:\}\:\d*', port)
        if portMatch:
            ports[idx] = re.sub(
                '\{\d*\:\}', f'{int(portMatch.group(1)) + index - 1}', port)


def setServiceContext(serviceConfig, index):
    copyPath = serviceConfig['build']['context']

    pathMatch = re.match('\{abspath\}', copyPath)
    if pathMatch:
        copyPath = os.path.normcase(copyPath.replace('{abspath}', abspath))

    numMatch = re.match('.*\{(\d*)\:\}', copyPath)
    if numMatch:
        originPath = re.sub('\{\d*\:\}', '', copyPath)
        copyPath = re.sub(
            '\{\d*\:\}', f'{int(numMatch.group(1)) + index - 1}', copyPath)

        createServiceContext(originPath, copyPath, index)

    serviceConfig['build']['context'] = copyPath


def createServiceContext(originPath, copyPath, index):
    try:
        shutil.copytree(originPath, copyPath)
        doc = ET.parse(os.path.join(
            copyPath, 'hadoop.etc.hadoop/yarn-site.xml'))
        root = doc.getroot()

        for property in root.iter("property"):
            value = property.find('value')

            numMatch = re.match('.*\{(\d*)\:\}', value.text)
            if numMatch:
                value.text = re.sub(
                    '\{\d*\:\}', f'{int(numMatch.group(1)) + index - 1}', value.text)

        doc.write(os.path.join(copyPath, 'hadoop.etc.hadoop/yarn-site.xml'))

        print(
            f"Directory '{originPath}' has been copied to '{copyPath}' successfully")
    except OSError as error:
        print(error)
        print(f"Directory '{originPath}' can not be copied to '{copyPath}'")


def removeServiceContext(path):
    try:
        shutil.rmtree(path)
        print(f"Directory '{path}' has been removed successfully")
    except OSError as error:
        print(error)
        print(f"Directory '{path}' can not be removed")
