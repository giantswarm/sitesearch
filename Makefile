#!/bin/bash

PROJECT=sitesearch
COMPANY=giantswarm
registry=registry.giantswarm.io


build:
	docker build -t $(registry)/$(COMPANY)/$(PROJECT) .

run:
	docker run --name=sitesearch --rm -p 9200:9200 $(registry)/$(COMPANY)/$(PROJECT)


delete:
	docker stop sitesearch
	docker rm sitesearch
	docker rmi $(registry)/$(COMPANY)/$(PROJECT)
