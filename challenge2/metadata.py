import requests
import json

def metadata():
    url = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
    headers = {'Metadata': 'True'}
    response = requests.get(url, headers=headers)
    print (json.dumps(response.json(), indent=2, sort_keys=True))
    json_response = response.json()
    return(json_response)


def fetch(data,v):
    for key,value in data.items():
        if v==key:
         print (str(key)+' is -> '+str(value))
        elif isinstance(value,dict):
            fetch(value,v)
        elif isinstance(value,str):
            print(value)
        elif isinstance(value, list):
            for val in value:
                if isinstance(val, str):
                    pass
                elif isinstance(val, list):
                    pass
                else:
                    fetch(val,v)



if __name__ == "__main__":
  data=metadata()
  fetch(data,"privateIpAddress")
  fetch(data,"computerName")