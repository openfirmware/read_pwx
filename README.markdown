# read_pwx

Reads PWX files from Training Peaks/Timex. To be used to convert to other formats.

## Tests

Tests are written in RSpec. Running the tests is fairly straight-forward:

    $ bundle install
    $ rspec spec

Specs are tested with real data in the `spec/fixtures` directory.

## Roadmap

There are a few tentative features I would like to add to this gem to make it more useful (at least for me). I will attempt to follow semantic versioning.

### Future Features

* Support export of PWX data into Garmin Training Center files (TCX)
* Support export of PWX data into GPS Exchange Format files (GPX)
* Support export of PWX data into Flexible and Interoperable Data Transfer files (FIT)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/read_pwx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
