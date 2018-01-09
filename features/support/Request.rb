class Request
  attr_accessor :name
  attr_accessor :collection_id
  attr_accessor :id
  attr_accessor :url
  attr_accessor :method

  def initialize(hash)
    @name=hash['name']
    @collection_id=hash['collection_id']
    @id=hash['id']
    @url=hash['request']['url']
    @method=hash['request']['method']
  end
end