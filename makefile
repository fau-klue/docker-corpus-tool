.PHONY: cwb ucs cwb-ucs

cwb:
	docker build --pull -t cwb -f cwb/Dockerfile .
ucs:
	docker build --pull -t ucs -f ucs/Dockerfile .
cwb-ucs:
	docker build --pull -t cwb-ucs -f cwb-ucs/Dockerfile .
