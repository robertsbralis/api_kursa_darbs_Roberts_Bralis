def set_active_project

    responce = put('https://www.apimation.com/projects/active/'+@project.project_id,
                   headers: {'Content-Type'=>'application/json'},
                   cookies: @test_user.session_cookie,
                   payload: {})
    # Check if correct 204 call is received
    assert_equal(204, responce.code,"Setting active project failed! Responce: #{responce}")
end

def create_environment(env_name)
  environment_payload={:name =>env_name}.to_json
  responce=post('https://www.apimation.com/environments',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: environment_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  @project.set_environments(env_name,responce_hash['id'])
  assert_equal(@project.environments.last['name'], responce_hash['name'], 'Name in the responce in incorrent !')
  assert_equal(@project.environments.last['id'], responce_hash['id'], 'Project id in the responce in incorrect !')
end

def  create_global_variable(name,value)
  @project.global_variables.push({'key'=>'$'+name,'value'=>value})
  variable_payload={:global_vars =>@project.global_variables}.to_json
  responce = put('https://www.apimation.com/environments/'+@project.environments.last['id'],
                 headers: {'Content-Type'=>'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: variable_payload)
  #Check if 204 No Content (Successful request) is received
  assert_equal(204, responce.code,"Setting global var failed! Responce: #{responce}")
end

def create_collection(name)
  collection_payload={:description=>'',:name =>name}.to_json
  responce=post('https://www.apimation.com/collections',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: collection_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct name is sent in responce
  assert_equal(name.to_s,responce_hash['name'],"Creating collection failed! Responce: #{responce}")
  @collections.push(responce_hash)
end