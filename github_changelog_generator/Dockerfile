FROM ruby:3-alpine

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk --no-cache add git nodejs curl jq bash make

ENV VERSION=1.15.2
RUN gem install github_changelog_generator --version ${VERSION}

WORKDIR /app

CMD [ "github_changelog_generator", "--no-filter-by-milestone", "--exclude-labels", "duplicate,question,invalid,wontfix,admin" ]
