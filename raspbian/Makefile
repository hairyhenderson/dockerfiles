build: Dockerfile
	@docker buildx build \
		--platform linux/amd64,linux/arm64,linux/arm  \
		-t hairyhenderson/raspbian:buster -t hairyhenderson/raspbian \
		--push \
		.
