export GO15VENDOREXPERIMENT = 1

VERSION := $(shell git describe --tags --always --dirty)
REVISION := $(shell git rev-parse --sq HEAD)
PACKAGES := $(shell go list ./... | grep -v '/vendor/')

.DEFAULT_GOAL := check

ifndef GOBIN
GOBIN := $(shell echo "$${GOPATH%%:*}/bin")
endif

LINT := $(GOBIN)/golint
GOX := $(GOBIN)/gox

$(LINT): ; @go get github.com/golang/lint/golint
$(GOX): ; @go get -v github.com/mitchellh/gox

.PHONY: build
build:
	@go build -ldflags "-X main.VersionString=$(VERSION) -X main.RevisionString=$(REVISION)" $(PACKAGES)

.PHONY: dist
dist: $(GOX)
	@$(GOX) -ldflags "-X main.VersionString=$(VERSION) -X main.RevisionString=$(REVISION)" -os 'linux darwin windows' -arch '386 amd64'  -output 'dist/{{.OS}}_{{.Arch}}' $(PACKAGES)

.PHONY: vet
vet:
	@go vet $(PACKAGES)

.PHONY: lint
lint: $(LINT)
	@exit $$($(LINT) . | tee /dev/tty | wc -l)

.PHONY: test
test:
	@go test $(PACKAGES) github.com/jszwedko/circleci-cli/vendor/encoding/json

.PHONY: check
check: vet lint test build
