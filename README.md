## Hookline ID3 Extractor

Ruby script that monitors a configurable directory for mp3 files. When files are added to the directory, the ID3 data is extracted and written to a MySQL database.

### Configuration

Set both the database credentials and directory to watch in 'config/config.yml'.

### Running at start-up

Run `rake install_launchctl_script` to create a launchd script that starts the ruby process on boot.

### Set-up

Create a database and tables using schema.sql.

__NOTE.__ This will drop and recreate the database from scratch.

    $ mysql -uroot < schema.sql

### Tests

    $ ruby -Ilib test/*_test.rb
