all: gomplate-ci-build/image.iid

%/image.iid: %/Dockerfile
	docker build \
		--progress auto \
		--iidfile $@ \
		-f $< \
		$(dir $<)

dockerimage = "ghcr.io/hairyhenderson/$(patsubst %/image.tag,%,$(1))"

%/image.tag: %/image.iid
	docker tag $(shell cat $<) $(call dockerimage,$@)
	@echo $(call dockerimage,$@) > $@

%/image.scanned: %/image.tag .trivyignore
	trivy i --exit-code 1 --ignore-unfixed --security-checks vuln --vuln-type os,library --severity HIGH,CRITICAL $(shell cat $<)
	@cat $< > $@

%/image.pushed: %/image.tag
	docker push $(shell cat $<)
	@echo "$(call dockerimage,$@)" > $@

clean:
	-@rm */image.iid */image.tag */image.scanned

.github/workflows/build.yml: .github/workflows/build.yml.tmpl */.* */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

.github/dependabot.yml: .github/dependabot.yml.tmpl */.ignore */Dockerfile
	@gomplate -c dir=./ -f $< -o $@

gen: .github/workflows/build.yml .github/dependabot.yml

.PHONY: clean
.DELETE_ON_ERROR:
.SECONDARY:
