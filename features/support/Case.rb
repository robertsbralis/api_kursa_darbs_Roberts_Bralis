class Test_Case
  attr_accessor :name
  attr_accessor :case_id
  attr_accessor :description

  def initialize(hash)
    @name=hash['name']
    @case_id=hash['case_id']
    @description=hash['description']
  end
end