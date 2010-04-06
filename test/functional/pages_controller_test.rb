require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test "should get index" do
    Page.make
    Setting.first
    Upload.make
    get :index
    assert_response :success
  end

  test "show" do
    p = Page.make
    get :show, :id => p.slug
    assert_response :success
  end

  test "show requires page" do
    assert_raises ActiveRecord::RecordNotFound do
      get :show, :slug => 'invalid'
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post :create, :page => Page.plan
    end
    assert_redirected_to admin_path
  end

  test "should get edit" do
    p = Page.make
    get :edit, :id => p.to_param
    assert_response :success
  end

  test "should update page" do
    p = Page.make
    put :update, :id => p.to_param, :page => {:title => 'changed'}
    p.reload
    assert_equal 'changed', p.title
    assert_redirected_to admin_path
  end

  test "should destroy page" do
    p = Page.make
    assert_difference('Page.count', -1) do
      delete :destroy, :id => p.to_param
    end
    assert_redirected_to admin_path
  end

  test "should get home" do
    get :show, :id => 'home'
    assert_response :success
  end

  test "should use custom layout for show action" do
    p = Page.make
    Setting.first.update_attribute(:layout, '<title><%= "custom" + " layout" %></title>')
    get :show, :id => p.slug
    assert_select 'title', 'custom layout'
  end

  test "should allow erb in pages" do
    p = Page.make(:body => '<div id="<%= "hello" + "world" %>"></div>')
    get :show, :id => p.slug
    assert_select '#helloworld'
  end
end