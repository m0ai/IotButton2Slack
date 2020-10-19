all: configure publish

configure:
	poetry pip install requests -t ./lambda

publish:
	cd ./lambda && zip -r ../lambda.zip .

