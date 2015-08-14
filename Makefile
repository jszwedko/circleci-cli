VERSION := $(shell git describe --tags --always --dirty)
REVISION := $(shell git rev-parse --sq HEAD)
.DEFAULT_GOAL := check

ifndef GOBIN
GOBIN := $(shell echo "$${GOPATH%%:*}/bin")
endif

GOPATH := "$(PWD):$(PWD)/vendor"

LINT := $(GOBIN)/golint
GB := $(GOBIN)/gb
GOX := $(GOBIN)/gox

$(LINT): ; @go get github.com/golang/lint/golint
$(GB): ; @go get github.com/constabulary/gb/...
$(GOX): ; @go get -v github.com/mitchellh/gox

.PHONY: build
build: $(GB)
	@$(GB) build -ldflags "-X main.VersionString $(VERSION) -X main.RevisionString $(REVISION)" ./...

.PHONY: dist
dist: $(GB) $(GOX)
	@GOPATH=$(GOPATH) $(GOX) -ldflags "-X main.VersionString $(VERSION) -X main.RevisionString $(REVISION)" -os 'linux darwin windows' -arch '386 amd64'  -output 'dist/{{.OS}}_{{.Arch}}' circleci

.PHONY: vet
vet:
	@GOPATH=$GOPATH go vet ./...

.PHONY: lint
lint: $(LINT)
	@exit $$(GOPATH=$(GOPATH) $(LINT) circleci | tee /dev/tty | wc -l)

.PHONY: test
test:
	@gb test

.PHONY: check
check: vet lint test build
