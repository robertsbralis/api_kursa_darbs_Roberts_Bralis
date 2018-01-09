class Project
  attr_accessor :name
  attr_accessor :project_id
  attr_accessor :environments
  attr_accessor :global_var
  attr_accessor :collections
  attr_accessor :requests
  attr_accessor :test_cases

  def initialize(name,project_id)
    @name=name
    @project_id=project_id
    @environments ||=[]
    @global_var ||=[]
    @collections ||=[]
    @requests ||=[]
    @test_cases ||=[]
  end

  def set_environments(hash)
    @environments = @environments.push(Environment.new(hash))
  end

  def set_collection(hash)
    @collections=@collections.push(Collection.new(hash))
  end


  def set_request(hash)
    @requests=@requests.push(Request.new(hash))
  end

  def set_case(hash)
    @test_cases=@test_cases.push(Test_Case.new(hash))
  end
end