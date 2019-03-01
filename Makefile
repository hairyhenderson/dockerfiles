all: gomplate-ci-build/image.iid

%/image.iid: %/Dockerfile
	@docker build \
		--progress auto \
		--iidfile $@ \
		-f $< \
		$(dir $<)

clean:
	-@rm */image.iid

.circleci/config.yml: .circleci/config.yml.tmpl */.ignore
	@gomplate -c dir=./ -f $< -o $@

.PHONY: clean
.DELETE_ON_ERROR:
.SECONDARY:
