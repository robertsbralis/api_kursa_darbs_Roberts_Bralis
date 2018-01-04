class Collection
  attr_accessor :name
  attr_accessor :id

  def initialize(hash)
    @name=hash['name']
    @id=hash['id']
  end
end