.PHONY: test

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test

test cov:
	PYTHONPATH=. py.test  --verbose -s ---cov=. --cov-report example

test_xunit:
	PYTHONPATH=. py.test -s --cov=. --cov-report xml --junit-xml=test_results.example

test_smoke:
	curl --fail 127.0.0.1:5000

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

docker_build:
	docker build -t hello-world-printer .

USERNAME=knap25
TAG=$(USERNAME)/hello-world-printer

docker_push: docker_build
			 @docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
			 docker tag hello-world-printer $(TAG); \
			 docker push $(TAG); \
			 docker logout;
