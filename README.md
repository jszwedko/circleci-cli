## circleci-cli [![Circle CI](https://circleci.com/gh/jszwedko/circleci-cli.svg?style=svg)](https://circleci.com/gh/jszwedko/circleci-cli)

CLI for interacting with CircleCI's API.

Allows you to list recent builds, projects, retry builds, and more.

For the Go library this uses, see:
[go-circleci](https://github.com/jszwedko/go-circleci).

Currently in alpha stages so the interface may change. Feedback and feature
requests are welcome! Install and run `circle -h` to see current help
documentation.

To install:
- Download appropriate binary for your architecture from the [releases](https://github.com/jszwedko/circleci-cli/releases) page
- Install somewhere in your `$PATH`
- Set `$CIRCLE_TOKEN` to an API token (you can generate one under your account
  settings). Consider adding this to your `~/.profile` or shell equivalent.

Alternatively, install the latest via: `GOVENDOREXPERIMENT=1 go get
github.com/jszwedko/circleci-cli` (requires Go >= 1.5 to be installed).

### Developing

Requires Go 1.5 and
[`GOVENDOREXPERIMENT=1`](https://docs.google.com/document/d/1Bz5-UB7g2uPBdOx-rw5t9MxJwkfpx90cqG9AFL0JAYo/edit)
to properly include dependencies.

Use [`gvt`](https://github.com/FiloSottile/gvt) to manipulate dependencies.

- Building: `make build`
- Testing: `make test`
- Building cross compiled binaries: `make dist` (will install
  [gox](https://github.com/mitchellh/gox) if needed)
