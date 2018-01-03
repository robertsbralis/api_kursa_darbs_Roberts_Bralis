When(/^I login in apimation as regular user$/) do
  login_positive
end
Then(/^I create a new environment called (.*) in project$/) do |env|
  set_active_project
  create_environment(env)
end
Then(/^I add global variable - username and password and project id$/) do
    create_global_variable('user',@test_user.email)
    create_global_variable('password',@test_user.password)
    create_global_variable('project_id',@project.project_id)
end
Then(/^I create 2 collections - (.*) and (.*)/) do |col1,col2|
  create_collection(col1)
  create_collection(col2)
end
Then(/^I create 2 requests: login and set project active$/) do
  create_login_request
  create_project_request
end
And(/^I create test case with name: (.*)$/) do |name|
  create_test_case(name)
end