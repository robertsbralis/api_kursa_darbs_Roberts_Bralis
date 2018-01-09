def delete_environments(env_name)
  responce=delete('https://www.apimation.com/environments/'+@project.environments.detect{|e| e.name==env_name}.id,
                  headers:{'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie)
  #Check if 204 No Content is received
  assert_equal(204, responce.code, "Deleting environment failed! Responce: #{responce}")
  # Delete environment from environments array
  @project.environments.delete(@project.environments.detect{|e| e.name==env_name})
end

def delete_collection(collection)
  responce=delete('https://www.apimation.com/collections/'+@project.collections.detect{|e| e.name==collection}.id,
                  headers:{'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie)
  #Check if 204 No Content is received
  assert_equal(204, responce.code, "Deleting collection failed! Responce: #{responce}")
  # Delete collection from collections array
  @project.collections.pop
end

def delete_test_case(test)
  responce=delete('https://www.apimation.com/cases/'+@project.test_cases.detect{|e| e.name==test}.case_id,
                  headers:{'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie)
  #Check if 204 No Content is received
  assert_equal(204, responce.code, "Deleting collection failed! Responce: #{responce}")
  # Delete test case from test case array
  @project.test_cases.pop
end