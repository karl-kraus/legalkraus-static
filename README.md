# Karl Kraus: Rechtsakten der Kanzlei Oskar Samek. Wissenschaftliche Edition 


## set up dev-environment

* clone the repo
* set up a python dev-environment, e.g.
```bash
python -m venv venv
source venv bin/bin/activate
pip install -r requirements.txt`
```
* install saxon `./shellscripts/script.sh`

## get the data

* The data for this application is not part of this repo but curated in [legalkraus-data](https://github.com/karl-kraus/legalkraus-data).
* run `./fetch_data.sh` to get and process the data

## build the app
* run `ant`

## start the app
* change directory into `html` and start some server, e.g. 
```bash
cd html
python -m http.server
```
* open http://127.0.0.1:8000/



----
* build with [DSE-Static-Cookiecutter](https://github.com/acdh-oeaw/dse-static-cookiecutter)
