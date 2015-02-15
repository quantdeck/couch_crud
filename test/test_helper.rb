# Copyright (c) 2015 Quantdeck Systems Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.

# Author::    Iain Gray (mailto:support@quantdeck.com)
# Copyright:: Copyright (c) 2015 Quantdeck Systems Ltd
# License::   Apache License Version 2.0


require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'couchCRUD'

COUCHDB_URL = ENV['CLOUDANT_TEST_URL']  || "http://127.0.0.1:5984/couch-crud-test"