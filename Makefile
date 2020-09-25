all: gomplate-ci-build/image.iid

%/image.iid: %/Dockerfile
	@docker build \
		--progress auto \
		--iidfile $@ \
		-f $< \
		$(dir $<)

clean:
	-@rm */image.iid

.github/workflows/build.yml: .github/workflows/build.yml.tmpl */.ignore */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

.github/dependabot.yml: .github/dependabot.yml.tmpl */.ignore */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

gen: .github/workflows/build.yml .github/dependabot.yml

.PHONY: clean
.DELETE_ON_ERROR:
.SECONDARY:
