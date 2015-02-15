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


require "couch_crud/version"
require "couch_crud/errors"
require "couchrest"
require "contracts"

include Contracts

module CouchCrud

  # Creates a new document with the supplied Hash
  #
  # Returns an Object with ID and operation result
  # Raises a DocConflictError if a document already exists with supplied ID
  #
  # Parameters:
  # +doc+:: Hash with document contents (including optional _id)
  Contract Hash => Object
  def create_document(doc)     
    if !doc['_id'].nil? && document_exists?(doc['_id']) then
      raise DocConflictError 
    else
      res = connection.save_doc(doc)
    end        
  end

  # Retrieves the document for a specific ID
  #
  # Returns the Couchrest Document if successful
  # Raises a DocNotFoundError if the doc doesn't exist
  #
  # Parameters : 
  # +id+:: id of the document to retrieve
  Contract String => Object
  def read_document(id)
    begin
      doc = connection.get(id)
    rescue RestClient::ResourceNotFound
      raise DocNotFoundError
    end        
  end

  # Updates a document when passed a Hash containing an _id
  #
  # Returns an Object with ID and operation result
  # Raises a DocNotFoundError if the doc doesn't exist
  #
  # Parameters : 
  # +doc+:: Hash with document contents (including optional _id)
  Contract ({'_id' => String}) => Object
  def update_document(doc)        
    raise DocNotFoundError unless document_exists?(doc['_id'])
    connection.save_doc(doc)
  end

  # Deletes a document if it exists
  # Returns true on success
  # Raises a DocNotFoundError if the doc doesn't exist
  #
  # Parameters : 
  # +id+:: id of the document to delete
  Contract String => Object
  def delete_document(id)
    begin
    connection.get(id).destroy
  rescue RestClient::ResourceNotFound
    raise DocNotFoundError
  end
  end

  # Checks if document exists for given ID
  # Returns true or false
    # Parameters : 
  # +id+:: id of the document to check
  Contract String => Or.new(true, false)
  def document_exists?(id)
    begin
      connection.get(id)
    rescue RestClient::ResourceNotFound
      return false
    end  
    true
  end

  private

  def connection
    CouchRest.database(@couchdb_url)
  end

end
