IMAGE_NAME = clouddst-reviewrot-frontend

build:
	docker build -t $(IMAGE_NAME) .

deploy:
	oc start-build $(IMAGE_NAME)

destroy:
	oc delete {bc,dc,is,services}/$(IMAGE_NAME) is/nonroot-nginx

create:
	oc new-app https://github.com/querti/clouddst-reviewrot.git \
		--context-dir=frontend \
		--strategy=docker \
		--name $(IMAGE_NAME)
	oc volume dc/$(IMAGE_NAME) --add \
		--type=pvc \
		--claim-name=json-data \
		--mount-path=/opt/data
