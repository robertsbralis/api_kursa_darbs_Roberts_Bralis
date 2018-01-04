def create_login_request
  request_name='login_case'
  steps_payload='{"name":"'+request_name+'","description":"","request":{"method":"POST","url":"https://www.apimation.com/login","type":"raw","body":"{\"login\":\"'+@test_user.email+'\",\"password\":\"'+@test_user.password+'\"}","binaryContent":{"value":"","filename":""},"urlEncParams":[{"name":"","value":""}],"formData":[{"type":"text","value":"","name":"","filename":""}],"headers":[{"name":"Content-Type","value":"application/json"}],"greps":[],"auth":{"type":"noAuth","data":{}}},"paste":false,"collection_id":"'+@project.collections.detect{|e| e.name=='Login'}.id+'"}'
  responce=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct collection
  assert_equal(@project.collections.detect{|e| e.name=='Login'}.id,responce_hash['collection_id'],"Incorrect collection  returned! Responce: #{responce}")
  # # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  # #Check if correct url is returned
  assert_equal(responce_hash['request']['url'],'https://www.apimation.com/login',"Incorrect URL returned! Responce: #{responce}")
  @project.set_request(responce_hash)
end




def create_project_request
  request_name='set_project'
  steps_payload='{"name":"'+request_name+'","description":"","request":{"method":"PUT","url":"https://www.apimation.com/projects/active/'+@project.project_id+'","type":"raw","body":"","binaryContent":{"value":"","filename":""},"urlEncParams":[{"name":"","value":""}],"formData":[{"type":"text","value":"","name":"","filename":""}],"headers":[{"name":"Content-Type","value":"application/json"}],"greps":[],"auth":{"type":"noAuth","data":{}}},"paste":false,"collection_id":"'+@project.collections.detect{|e| e.name=='Projects'}.id+'"}'
  responce=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct collection
  assert_equal(@project.collections.detect{|e| e.name=='Projects'}.id,responce_hash['collection_id'],"Incorrect collection  returned! Responce: #{responce}")
  # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  #Check if correct url is returned
  assert_equal('https://www.apimation.com/projects/active/'+@project.project_id,responce_hash['request']['url'],"Incorrect URL returned! Responce: #{responce}")
  @project.set_request(responce_hash)
end
