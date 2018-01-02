class Project
  attr_accessor :project_id
  attr_accessor :environments
  attr_accessor :global_var


  def initialize(project_id)
    @project_id=project_id
    @environments ||=[]
    @global_var ||=[]
  end

  def set_environments(env,id)
    hash={'name'=>env,'id'=>id}
    @environments = @environments.push(hash)
  end


end