def create_environment(env_name)
  environment_payload={:name =>env_name}.to_json
  responce=post('https://www.apimation.com/environments',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: environment_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Add environment to project environments array
  @project.set_environments(responce_hash)
  # Check if environment name is returned correct
  assert_equal(@project.environments.last.name, responce_hash['name'], 'Name in the responce in incorrent !')
  # Check if environment id is returned correct
  assert_equal(@project.environments.last.id, responce_hash['id'], 'Project id in the responce in incorrect !')
end

def  create_global_variable(name,value)
  # Create hash for global variable in payload
  global_variable=Hash.new('key'=>'$'+name,'value'=>value)
  variable_payload={:global_vars =>global_variable}.to_json
  responce = put('https://www.apimation.com/environments/'+@project.environments.last.id,
                 headers: {'Content-Type'=>'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: variable_payload)
  #Check if 204 No Content (Successful request) is received
  assert_equal(204, responce.code,"Setting global var failed! Responce: #{responce}")
  # Push the global variable in project global variable array
  @project.global_var.push(global_variable)
end

def check_environment(env_name)
  responce = get('https://www.apimation.com/environments/'+@project.environments.detect{|e| e.name==env_name.to_s}.id,
                 headers:{},
                 cookies: @test_user.session_cookie)
  # Check if 200 OK is returned
  assert_equal(200, responce.code,"Getting environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if environment name is returned correctly
  assert_equal(env_name.to_s, responce_hash['name'],"Returned incorrect environment name! Responce: #{responce}")
  # Check if environment id is returned correctly
  assert_equal(@project.environments.detect{|e| e.name==env_name.to_s}.id, responce_hash['id'],"Returned incorrect environment id! Responce: #{responce}")
end