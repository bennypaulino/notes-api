# README


### Built with Ruby on Rails

* Ruby 2.3.3
* Rails 4.2.8
* PostgreSQL
* Travis CI
* Coveralls

### Automated Continuous Integration with Travis CI

Continuous Integration (CI) is the practice of integrating new code into the master branch frequently, to help detect merge conflicts, bugs, and improve the quality of the software a development team writes.

CI is usually accompanied by running an application's test suite against the latest code changes, and flagging any test failures that are found. Developers are expected to investigate and fix these failures to maintain a passing test suite and therefore quality.

[Travis CI](https://travis-ci.org) is a build server that helps automate the CI process. Travis CI runs an application's tests against the latest changes pushed to the application's code respository. In this project, Travis CI runs the project's tests (`rake test`) on pull requests and on changes to the master branch.

Travis CI configuration how-to and example:
- [.travis.yml](.travis.yml) - Travis CI's configuration file (with instructions)
- [notes-api Travis CI build!](https://travis-ci.org/bennypaulino/notes-api)
- Travis CI badge for notes-api: [![Build Status](https://travis-ci.org/bennypaulino/notes-api.svg?branch=master)](https://travis-ci.org/bennypaulino/notes-api)

### Test Coverage with Coveralls

[Coveralls](https://coveralls.io/) takes the build data from whichever CI service your project uses, parses it, and provides constant updates and statistics on your project's code coverage to show you how coverage has changed with the new build, and what isn't covered by tests. Coveralls even breaks down the test coverage on a file by file basis. You can see the relevant coverage, covered and missed lines, and the hits per line for each file, as well as quickly browse through individuals files that have changed in a new commit, and see exactly what changed in the build coverage.

Coveralls how-to:
- [Installation & Configuration](https://coveralls.zendesk.com/hc/en-us/articles/201769485-Ruby-Rails)
- [Coveralls Statistics for TimeTracker!](https://coveralls.io/github/bennypaulino/notes-api)
- Coveralls badge for TimeTracker: [![Coverage Status](https://coveralls.io/repos/github/bennypaulino/notes-api/badge.svg?branch=master)](https://coveralls.io/github/bennypaulino/notes-api?branch=master)
