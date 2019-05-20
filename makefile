.PHONY: cwb ucs cwb-ucs cqpweb

cwb:
	docker build --pull -t cwb -f cwb/Dockerfile cwb
ucs:
	docker build --pull -t ucs -f ucs/Dockerfile ucs
cwb-ucs:
	docker build --pull -t cwb-ucs -f cwb-ucs/Dockerfile cwb-ucs
cqpweb:
	docker build --pull -t cqpweb -f cqpweb/Dockerfile cqpweb
