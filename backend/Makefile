IMAGE_NAME = clouddst-reviewrot-backend

run:
	python aggregation.py

build:
	docker build -t $(IMAGE_NAME) .

deploy:
	oc start-build $(IMAGE_NAME)

destroy:
	oc delete {bc,dc,is}/$(IMAGE_NAME)

create:
	oc new-app https://github.com/querti/clouddst-reviewrot.git \
		--context-dir=backend \
		--strategy=docker \
		--name $(IMAGE_NAME)
	oc volume dc/$(IMAGE_NAME) --add \
		--type=pvc \
		--claim-name=json-data \
		--mount-path=/opt/data
	oc volume dc/$(IMAGE_NAME) --add \
		--type secret \
		--secret-name reviewrot-config \
		--mount-path=/secret/
