# read_pwx

Reads PWX files from Training Peaks/Timex. To be used to convert to other formats.

## Exporting to GPX

The `pwx` script can be used to convert a PWX file to GPX. When installing `read_pwx`, the binary is automatically installed to your rubygems bin directory. Note that the script outputs to STDOUT.

    $ pwx --output=gpx input.pwx > output.gpx

Alternatively you can use the `ReadPWX::Serializers::GPXSerializer` class method `dump` to convert a `ReadPWX::PWX::PWX` instance to a Nokogiri document. The document can then be dumped to_xml.

The GPX format is based on the [schema defined by Topographix](http://www.topografix.com/gpx.asp) with extensions from [Cluetrust](http://www.cluetrust.com/Schemas/gpxdata10.xsd). The following attributes are converted from PWX to GPX:

* Basic lap information (time, distance)
* Sensor data for samples
    * Cadence in RPM
    * Distance in metres
    * Heartrate in BPM
    * Power in Watts (Note: custom extension)
    * Temperature in Celcius

If a sensor reading is not present for a sample then it is omitted (instead of an empty element or element with `null` value).

Support for converting additional data from PWX to GPX is planned, specifically summary data. I will need a sample PWX file with advanced summary data to be able to write this feature, and I do not have any at the moment.

## Notes on PWX

The PWX file from the Timex Cycle Trainer adds some extensions to each sample element.

* hrmstatus
* gpsstatus
* spdstatus
* pmstatus
* cadstatus

It is allowed in the PWX schema to add arbitrary extensions, but I cannot find a source for these extensions that explains the meaning of their values. If someone knows this information from the PWX schema please let me know.

## Tests

Tests are written in RSpec. Running the tests is fairly straight-forward:

    $ bundle install
    $ rspec spec

Specs are tested with real data in the `spec/fixtures` directory.

## Roadmap

There are a few tentative features I would like to add to this gem to make it more useful (at least for me). I will attempt to follow semantic versioning.

### Future Features

* Support export of PWX data into Garmin Training Center files (TCX)
* Support export of PWX data into Flexible and Interoperable Data Transfer files (FIT)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/read_pwx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
