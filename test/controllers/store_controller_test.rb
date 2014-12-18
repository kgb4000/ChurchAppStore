require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'h3', 'Swim Suit by Kes'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
