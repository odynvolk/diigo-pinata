diigo-pinata
============
A Ruby client for Diigo.

Supports the following operations: login, add bookmark, add note.

# USAGE

## ruby

``` ruby
require 'diigo-pinata'

client = DiigoPinata::Client.new('username', 'password')
client.login
client.add_bookmark 'http://tubcat.com/', 'Tubcat', 'cats,xxl', false, 'I need to keep track of all sorts of cats.'
client.add_note 'My cats', 'I once had two cats', 'cats'
```

# TODO

We need some tests...