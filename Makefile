all: configure publish

configure:
	pip install requests -t ./lambda

publish:
	cd ./lambda && zip -r ../lambda.zip .

