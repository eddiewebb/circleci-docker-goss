# GOSS test cases on CircleCI
[goss](https://github.com/aelsabbahy/goss) is a server spec testing tool. Here we use dgoss to apply those tests to our docker image.

This folder contains wrapper scripts that modify the docker image state to mimic certain real-world scenarios.

goss in turn will call these, and verify output/exit codes against specs in [goss.yaml](goss.yaml)

## install locally
Install dgoss by following [this guide](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss#installation)

## Caveats - Docker Entrypoints
This image uses an entrypoint that expects 2 key files to exist, as well as some parameters.
Their absence causes an immediate exit, before tests can be executed.

As a result we provide a testing entrypoint that creates the files needed for testing.
Our goss tests execute the primary entrypoint to ensure validity given certain conditions.

## testing
See [test/runTests.sh](test/runTests.sh)
```
test/runTests.sh

```

## adding tests
Highly suggest reading [goss docs](https://github.com/aelsabbahy/goss/blob/master/docs/manual.md) first.

To add tests, build and run the container.

```
docker build . -t my-image:test
dgoss edit --entrypoint=/test/gossEntrypoint.sh my-image:test
```

Once inside the container, use `goss add [type] [target]` as defiend in the docs.
**NOTE** goss will export the generated goss.yaml to local file system on exit, copy new or modified snippers into `goss.yaml`
