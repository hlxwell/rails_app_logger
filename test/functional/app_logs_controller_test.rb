require 'test_helper'

class AppLogsControllerTest < ActionController::TestCase
  setup do
    @app_log = app_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_log" do
    assert_difference('AppLog.count') do
      post :create, :app_log => @app_log.attributes
    end

    assert_redirected_to app_log_path(assigns(:app_log))
  end

  test "should show app_log" do
    get :show, :id => @app_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @app_log.to_param
    assert_response :success
  end

  test "should update app_log" do
    put :update, :id => @app_log.to_param, :app_log => @app_log.attributes
    assert_redirected_to app_log_path(assigns(:app_log))
  end

  test "should destroy app_log" do
    assert_difference('AppLog.count', -1) do
      delete :destroy, :id => @app_log.to_param
    end

    assert_redirected_to app_logs_path
  end
end
