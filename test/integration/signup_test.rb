require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
    def setup
      User.destroy_all
    end

    test "sign up" do
    get register_path
    assert_response :success
    
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "Moki", email: "moki@gmail.com", password: "12345" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_equal "/users", path
    assert_equal "Welcome to the mokoblog Moki, your account has been successfully created", flash[:notice]
    assert_match "mokobloggers", response.body
  end
end
