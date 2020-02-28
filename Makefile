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

.github/workflows/build.yml: .github/workflows/build.yml.tmpl */.ignore */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

.dependabot/config.yml: .dependabot/config.yml.tmpl */.ignore */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

.PHONY: clean
.DELETE_ON_ERROR:
.SECONDARY:
