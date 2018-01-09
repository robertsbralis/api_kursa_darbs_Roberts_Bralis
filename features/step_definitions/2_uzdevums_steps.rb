When(/^I login in apimation as regular user$/) do
  login_positive
end
Then(/^I create a new environment called (.*) in project (.*)$/) do |env,project|
  set_active_project(project)
  create_environment(env)
  check_environment(env)
end
Then(/^I add global variable - (.*)$/) do |key|
  case key
    when 'username' then create_global_variable('user',@test_user.email)
    when 'password' then create_global_variable('password',@test_user.password)
    when 'project_id' then create_global_variable('project_id',@project.project_id)
    else raise 'Please specify correct global variables!'
  end
end

Then(/^I create collection - (.*)/) do |col|
  create_collection(col)
  check_collection(col)
end
Then(/^I create request: (.*)$/) do |request|
  case request
    when 'login' then create_login_request
    when 'set project active' then create_project_request
    else raise 'Please specify correct request!'
  end
end
