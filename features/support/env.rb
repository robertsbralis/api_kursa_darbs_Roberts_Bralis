Before() do
  @test_user = User.new('bralisroberts@gmail.com','parole')
  @project=Project.new('4ffea760-d67b-11e7-8bcd-5d3e2d5d7554')
  @collections ||=[]
end