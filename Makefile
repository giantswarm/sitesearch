#!/bin/bash

PROJECT=sitesearch
registry=registry.giantswarm.io


build:
	docker build -t $(registry)/$(PROJECT) .

run:
	docker run --name=sitesearch --rm -p 9200:9200 $(registry)/$(PROJECT)


delete:
	docker stop sitesearch
	docker rm sitesearch
	docker rmi $(registry)/$(PROJECT)
