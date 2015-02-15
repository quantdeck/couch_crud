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

module CouchCrud

  # The base error class for all <tt>couch_crud</tt> error classes.
  class Error < StandardError; end
  # If a document conflicts with an existing document in the DB
  class DocConflictError < Error; end
  # If a document requested doesn't exist
  class DocNotFoundError < Error; end

end