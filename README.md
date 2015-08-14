## circleci-cli

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

### Developing

Uses [`gb`](http://getgb.io/) to build, running `make build` should install `gb` if needed.

- Building: `make build`
- Testing: `make test`
- Building cross compiled binaries: `make dist` (will install
  [gox](https://github.com/mitchellh/gox) if needed, but you may need to
  bootstrap via `gox -build-toolchain`)
