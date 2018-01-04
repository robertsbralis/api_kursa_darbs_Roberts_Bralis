Before() do
  @test_user = User.new('bralisroberts@gmail.com','parole')
end
After() do
  @project.environments.each do |env|
    delete_environments(env.name)
  end
  @project.collections.reverse.each do |col|
      delete_collection(col.name)
  end

  @project.test_cases.each do |test|
    delete_test_case(test.name)
  end
end