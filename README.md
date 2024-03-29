## Hookline ID3 Extractor

Ruby script that monitors a configurable directory for mp3 files. When files are added to the directory, the ID3 data is extracted and written to a MySQL database.

### Prerequisites

You'll need the [taglib][] library installed.

    brew install taglib

[taglib]: https://taglib.github.io/

### Configuration

Set both the database credentials and directory to watch in 'config/config.yml'.

### Running at start-up

Run `rake install_launchctl_script` to create a launchd script that starts the ruby process on boot.

### Set-up

Create a production and test database.

__NOTE.__ This will drop and recreate the database from scratch so make sure you don't have any data that you want to keep!

    $ rake create_dbs

### Tests

    $ ruby -Ilib test/*_test.rb
