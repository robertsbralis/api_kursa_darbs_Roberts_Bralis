And(/^I create test case with name: (.*)$/) do |name|
  create_test_case(name)
  check_test_case(name)
end