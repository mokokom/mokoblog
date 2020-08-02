require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "mok", email: "mok@gmail.com", password: "12345" )
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get new_article_path
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "create an article", description: "create an article is simple", user_id: @user.id} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_equal "Article has been created successfully", flash[:notice]
    assert_match "create an article", response.body
  end
end
