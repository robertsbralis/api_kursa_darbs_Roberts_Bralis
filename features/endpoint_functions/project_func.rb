def set_active_project(name)
  responce = get('https://www.apimation.com/projects',
                 headers:{},
                 cookies: @test_user.session_cookie)
  responce_hash = JSON.parse(responce)
  @project=Project.new(name,responce_hash.detect{|e| e['name']==name}['id'])

  responce = put('https://www.apimation.com/projects/active/'+@project.project_id,
                   headers: {'Content-Type'=>'application/json'},
                   cookies: @test_user.session_cookie,
                   payload: {})
    # Check if correct 204 call is received
    assert_equal(204, responce.code,"Setting active project failed! Responce: #{responce}")
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
  @project.set_collection(responce_hash)
end

def create_test_case(name)
  request_name=name
  test_payload='{"name":"'+request_name+'","description":"this needs to be changed!!!","request":{"requests":[{"step_name":"'+@project.requests.detect{|e| e.name=='login_case'}.name+'","url":"'+@project.requests.detect{|e| e.name=='login_case'}.url+'","body":"{\"login\":\"'+@test_user.email+'\",\"password\":\"'+@test_user.password+'\"}","formData":[{"type":"text","value":"","name":"","filename":""}],"urlEncParams":[{"name":"","value":""}],"binaryContent":{"value":"","filename":""},"type":"raw","headers":[{"name":"Content-Type","value":"application/json"}],"method":"POST","greps":[{"type":"json","expression":"","varname":""}],"asserts":[]},{"step_name":"'+@project.requests.detect{|e| e.name=='set_project'}.name+'","url":"https://www.apimation.com/projects/active/'+@project.project_id+'","body":"","formData":[{"type":"text","value":"","name":"","filename":""}],"urlEncParams":[{"name":"","value":""}],"binaryContent":{"value":"","filename":""},"type":"raw","headers":[{"name":"Content-Type","value":"application/json"}],"method":"PUT","greps":[{"type":"json","expression":"","varname":""}],"asserts":[]}],"vars":[{"name":"","value":""}],"assertWarn":1}}'

   responce= post('https://www.apimation.com/cases',
                  headers: {'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: test_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  # Check if correct default description
  assert_equal('this needs to be changed!!!',responce_hash['description'],"Incorrect description returned! Responce #{responce}")
  @project.set_case(responce_hash)
end