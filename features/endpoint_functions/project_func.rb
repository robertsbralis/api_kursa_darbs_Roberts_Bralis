def set_active_project(name)
  responce = get('https://www.apimation.com/projects',
                 headers:{},
                 cookies: @test_user.session_cookie)
  responce_hash = JSON.parse(responce)
  @project=Project.new(responce_hash.detect{|e| e['name']==name}['id'])

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
  @project.global_var.push({'key'=>'$'+name,'value'=>value})
  variable_payload={:global_vars =>@project.global_var}.to_json
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



def create_login_request
  request_name='login_case'
  steps_payload='{"name":"'+request_name+'","description":"","request":{"method":"POST","url":"https://www.apimation.com/login","type":"raw","body":"{\"login\":\"'+@test_user.email+'\",\"password\":\"'+@test_user.password+'\"}","binaryContent":{"value":"","filename":""},"urlEncParams":[{"name":"","value":""}],"formData":[{"type":"text","value":"","name":"","filename":""}],"headers":[{"name":"Content-Type","value":"application/json"}],"greps":[],"auth":{"type":"noAuth","data":{}}},"paste":false,"collection_id":"'+@collections.detect{|e| e['name']=='Login'}['id']+'"}'
  responce=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct collection
  assert_equal(@collections.detect{|e| e['name']=='Login'}['id'],responce_hash['collection_id'],"Incorrect collection  returned! Responce: #{responce}")
  # # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  # #Check if correct url is returned
  assert_equal(responce_hash['request']['url'],'https://www.apimation.com/login',"Incorrect URL returned! Responce: #{responce}")

  @requests.push(responce_hash)

end




def create_project_request
  request_name='set_project'
  steps_payload='{"name":"'+request_name+'","description":"","request":{"method":"PUT","url":"https://www.apimation.com/projects/active/'+@project.project_id+'","type":"raw","body":"","binaryContent":{"value":"","filename":""},"urlEncParams":[{"name":"","value":""}],"formData":[{"type":"text","value":"","name":"","filename":""}],"headers":[{"name":"Content-Type","value":"application/json"}],"greps":[],"auth":{"type":"noAuth","data":{}}},"paste":false,"collection_id":"'+@collections.detect{|e| e['name']=='Projects'}['id']+'"}'
  responce=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct collection
  assert_equal(@collections.detect{|e| e['name']=='Projects'}['id'],responce_hash['collection_id'],"Incorrect collection  returned! Responce: #{responce}")
  # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  #Check if correct url is returned
  assert_equal('https://www.apimation.com/projects/active/'+@project.project_id,responce_hash['request']['url'],"Incorrect URL returned! Responce: #{responce}")

  @requests.push(responce_hash)
end



def create_test_case(name)
  request_name=name
  test_payload='{"name":"'+request_name+'","description":"this needs to be changed!!!","request":{"requests":[{"step_name":"'+@requests.detect{|e| e['name']=='login_case'}['name']+'","url":"'+@requests.detect{|e| e['name']=='login_case'}['request']['url']+'","body":"{\"login\":\"'+@test_user.email+'\",\"password\":\"'+@test_user.password+'\"}","formData":[{"type":"text","value":"","name":"","filename":""}],"urlEncParams":[{"name":"","value":""}],"binaryContent":{"value":"","filename":""},"type":"raw","headers":[{"name":"Content-Type","value":"application/json"}],"method":"POST","greps":[{"type":"json","expression":"","varname":""}],"asserts":[]},{"step_name":"'+@requests.detect{|e| e['name']=='set_project'}['name']+'","url":"https://www.apimation.com/projects/active/'+@project.project_id+'","body":"","formData":[{"type":"text","value":"","name":"","filename":""}],"urlEncParams":[{"name":"","value":""}],"binaryContent":{"value":"","filename":""},"type":"raw","headers":[{"name":"Content-Type","value":"application/json"}],"method":"PUT","greps":[{"type":"json","expression":"","varname":""}],"asserts":[]}],"vars":[{"name":"","value":""}],"assertWarn":1}}'

   responce= post('https://www.apimation.com/cases',
                  headers: {'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: test_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  @test_cases.push(responce_hash)
end

def get_projects
  responce = get('https://www.apimation.com/projects',
                 headers:{},
                 cookies: @test_user.session_cookie)
  responce_hash = JSON.parse(responce)
  responce_hash
end