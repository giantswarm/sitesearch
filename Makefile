#!/bin/bash

PROJECT=sitesearch
COMPANY=giantswarm
REGISTRY=quay.io


build:
	docker build -t $(REGISTRY)/$(COMPANY)/$(PROJECT) .

run:
	docker run --name=sitesearch --rm -p 9200:9200 $(REGISTRY)/$(COMPANY)/$(PROJECT)

delete:
	docker stop sitesearch
	docker rm sitesearch
	docker rmi $(REGISTRY)/$(COMPANY)/$(PROJECT)
