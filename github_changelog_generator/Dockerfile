FROM ruby:alpine

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN gem install github_changelog_generator

RUN apk --no-cache add git nodejs curl jq bash make

WORKDIR /app

CMD [ "github_changelog_generator", "--no-filter-by-milestone", "--exclude-labels", "duplicate,question,invalid,wontfix,admin" ]
