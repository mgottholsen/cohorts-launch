require 'test_helper'

class TwilioWufoosControllerTest < ActionController::TestCase
  setup do
    @twilio_wufoo = twilio_wufoos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twilio_wufoos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twilio_wufoo" do
    assert_difference('TwilioWufoo.count') do
      post :create, twilio_wufoo: { name: @twilio_wufoo.name, twilio_keyword: @twilio_wufoo.twilio_keyword, wufoo_formid: @twilio_wufoo.wufoo_formid }
    end

    assert_redirected_to twilio_wufoo_path(assigns(:twilio_wufoo))
  end

  test "should show twilio_wufoo" do
    get :show, id: @twilio_wufoo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twilio_wufoo
    assert_response :success
  end

  test "should update twilio_wufoo" do
    patch :update, id: @twilio_wufoo, twilio_wufoo: { name: @twilio_wufoo.name, twilio_keyword: @twilio_wufoo.twilio_keyword, wufoo_formid: @twilio_wufoo.wufoo_formid }
    assert_redirected_to twilio_wufoo_path(assigns(:twilio_wufoo))
  end

  test "should destroy twilio_wufoo" do
    assert_difference('TwilioWufoo.count', -1) do
      delete :destroy, id: @twilio_wufoo
    end

    assert_redirected_to twilio_wufoos_path
  end
end