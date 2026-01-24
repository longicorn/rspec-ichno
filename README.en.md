# rspec-ichno

When you run rspec, it will cache the code and skip the test run the next time the code is the same.

## Installation

[ichno](https://github.com/longicorn/ichno) must be installed

```
gem "rspec-ichno", git: 'https://github.com/longicorn/rspec-ichno.git', branch: 'master'
```

```bash
bundle install
```

## Usage

rspec-ichno is default disabled

enable all test case skip
(If ichno.cache.json exists and there are no code changes, tests will be skipped.
```bash
$ ICHNO=true bin/ichno -o result.json bundle exec rspec
$ ICHNO=1 bin/ichno -o result.json bundle exec rspec
```

for next test, create ichno.cache.json from result.json
```bash
$ bundle exec ichnotool result.json
```

disable a test case skip
```
it "test", ichno: false do
  # do something
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
