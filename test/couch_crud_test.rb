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


require 'test_helper'

class CrudTest
  include CouchCrud

  def initialize
    @couchdb_url = COUCHDB_URL
  end

end

describe CouchCrud do 

  before do
    @ct = CrudTest.new  
    @delete_ids = Array.new  
    db = CouchRest.database!(COUCHDB_URL)
    db.save_doc({'_id' => 'horse', :food => 'hay'})    
    db.save_doc({'_id' => 'dolphin', :food => 'fish'})    
  end

  after do
    CouchRest.database(COUCHDB_URL).delete!    
  end

  describe "when creating a document" do
    it "must check for an existing document" do 
      Proc.new{@ct.create_document({'_id'=> 'horse', :food => 'sardines'})}.must_raise CouchCrud::DocConflictError        
    end

    it "must save a new document with an id" do
      res =  @ct.create_document({'_id' => 'cow', :food => 'grass'})            
      res['id'].must_equal 'cow'      
    end

    it "must save a new document without an id" do 
      res =  @ct.create_document({'type' => 'grey goo', :food => 'everything'})          
      res['ok'].must_equal true
    end
  end

  describe "when reading a document" do
    it "must throw an error if document not found" do
      Proc.new{@ct.read_document('donkey')}.must_raise CouchCrud::DocNotFoundError
    end

    it "must return the document contents if key exists" do
      @ct.read_document('dolphin')[:food].must_equal 'fish'      
    end
  end

  describe "when updating a document" do
    it "must throw an error if document not found" do
      Proc.new{@ct.update_document({'_id' => 'donkey'})}.must_raise CouchCrud::DocNotFoundError
    end

    it "must update an existing document" do 
      doc = @ct.read_document('dolphin')
      doc['dislikes'] = 'tuna nets'
      @ct.update_document(doc)['ok'].must_equal true
      @ct.read_document('dolphin')['dislikes'].must_equal 'tuna nets'
    end
  end

  describe "when deleting a document" do
    it "must throw an error if the document does not exist" do 
      Proc.new{@ct.delete_document('zebra')}.must_raise CouchCrud::DocNotFoundError
    end

    it "must delete an existing document" do 
      @ct.create_document({'_id' => 'chicken', :food => 'corn'})
      @ct.delete_document('chicken').must_equal true
    end
  end

  describe "when checking if a document exists" do 
    it "must return true if doc exists" do
      @ct.create_document({'_id' => 'chicken', :food => 'corn'})
      @ct.document_exists?('chicken').must_equal true
    end

    it "must return false if doc does not exist" do
      @ct.document_exists?('turkey').must_equal false
    end
  end
  
end