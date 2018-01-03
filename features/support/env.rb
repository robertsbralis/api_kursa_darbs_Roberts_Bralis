Before() do
  @test_user = User.new('bralisroberts@gmail.com','parole')
  @project=Project.new('4ffea760-d67b-11e7-8bcd-5d3e2d5d7554')
  @collections ||=[]
  @requests ||=[]
  @test_cases ||=[]
end
After() do
  @project.environments.each do |env|
    delete_environments(env['name'])
  end
  @collections.reverse.each do |col|
      delete_collection(col['name'])
  end

  @test_cases.each do |test|
    delete_test_case(test['name'])
  end
end