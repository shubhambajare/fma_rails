require "test_helper"

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subcategory = subcategories(:one)
  end

  test "should get index" do
    get subcategories_url
    assert_response :success
  end

  test "should get new" do
    get new_subcategory_url
    assert_response :success
  end

  test "should create subcategory" do
    assert_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { alloted_budget: @subcategory.alloted_budget, category_id: @subcategory.category_id, description: @subcategory.description, name: @subcategory.name, remaining_budget: @subcategory.remaining_budget } }
    end

    assert_redirected_to subcategory_url(Subcategory.last)
  end

  test "should show subcategory" do
    get subcategory_url(@subcategory)
    assert_response :success
  end

  test "should get edit" do
    get edit_subcategory_url(@subcategory)
    assert_response :success
  end

  test "should update subcategory" do
    patch subcategory_url(@subcategory), params: { subcategory: { alloted_budget: @subcategory.alloted_budget, category_id: @subcategory.category_id, description: @subcategory.description, name: @subcategory.name, remaining_budget: @subcategory.remaining_budget } }
    assert_redirected_to subcategory_url(@subcategory)
  end

  test "should destroy subcategory" do
    assert_difference('Subcategory.count', -1) do
      delete subcategory_url(@subcategory)
    end

    assert_redirected_to subcategories_url
  end
end
