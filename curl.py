import requests
import json
import sys

url = 'https://api.fyre.ibm.com/rest/v1/?operation=query&request=showclusterdetails&cluster_name=%s' %(sys.argv[1])
username = sys.argv[2]
password = sys.argv[3]

response = requests.get(url, auth=(username,password),verify=False)
cluster_data = json.loads(response.text)
print cluster_data[sys.argv[1]][0]['publicip']