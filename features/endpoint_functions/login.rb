require 'rest-client'
require 'test-unit'

def login_positive
  login_payload = {:login => @test_user.email,:password => @test_user.password}.to_json
  responce=post('https://www.apimation.com/login',
                headers: {'Content-Type'=>'application/json'},
                cookies: {},
                payload: login_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Login failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if user email is returned correct
  assert_equal(@test_user.email, responce_hash['email'], 'Email in the responce in incorrent')
  # Check if user id is not empty
  assert_not_equal(nil, responce_hash['user_id'], 'User id is empty')
  # Check if user login name (email in our case) is returned correct
  assert_equal(@test_user.email, responce_hash['login'], 'Login in the responce in incorrent')
  # Set session cookies for our user
  @test_user.set_session_cookie(responce.cookies)
  # Set user id for our user
  @test_user.set_user_id(responce_hash['user_id'])
end