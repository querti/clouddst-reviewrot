build:
	$(MAKE) build -C backend
	$(MAKE) build -C frontend

deploy:
	$(MAKE) deploy -C backend
	$(MAKE) deploy -C frontend

destroy:
	$(MAKE) destroy -C backend
	$(MAKE) destroy -C frontend

create:
	$(MAKE) create -C backend
	$(MAKE) create -C frontend

watch:
	watch oc status
