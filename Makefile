NAME = vixns/base
VERSION = latest

.PHONY: all build release

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

release:
	docker push $(NAME)

