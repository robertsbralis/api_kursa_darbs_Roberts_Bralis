def create_environment(env_name)
  environment_payload={:name =>env_name}.to_json
  responce=post('https://www.apimation.com/environments',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: environment_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  @project.set_environments(responce_hash)
  assert_equal(@project.environments.last.name, responce_hash['name'], 'Name in the responce in incorrent !')
  assert_equal(@project.environments.last.id, responce_hash['id'], 'Project id in the responce in incorrect !')
end

def  create_global_variable(name,value)
  @project.global_var.push({'key'=>'$'+name,'value'=>value})
  variable_payload={:global_vars =>@project.global_var}.to_json
  responce = put('https://www.apimation.com/environments/'+@project.environments.last.id,
                 headers: {'Content-Type'=>'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: variable_payload)
  #Check if 204 No Content (Successful request) is received
  assert_equal(204, responce.code,"Setting global var failed! Responce: #{responce}")
end