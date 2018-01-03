Before() do
  @test_user = User.new('bralisroberts@gmail.com','parole')
  @project=0
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