# couch_crud

couch_crud is a mixin which provides minimal, simple CRUD operations for CouchDB

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'couch_crud'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install couch_crud

## Usage

1. `require couch_crud` then `include CouchCrud` in your class
2. set `@couchdb_url` to be your couchdDB database access url
3. Then use the CRUD functions:
 - `create_document(document Hash)` to create
 - `read_document(document id)` to to read
 - `update_document(document Hash)` to update
 - `delete_document(document id)` to delete
 - `document.exists?(document id)` to check if a doc exists
4. Features like attachments, versions etc. aren't currently supported, but may be later on

## Contributing

1. Fork it ( https://github.com/quantdeck/couch_crud/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Note that testing requires a running CouchDB server  "http://127.0.0.1:5984/", or a url specified in ENV['CLOUDANT_TEST_URL']
