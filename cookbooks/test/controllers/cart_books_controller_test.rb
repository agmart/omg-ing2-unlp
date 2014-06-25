require 'test_helper'

class CartBooksControllerTest < ActionController::TestCase
  setup do
    @cart_book = cart_books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_book" do
    assert_difference('CartBook.count') do
      post :create, cart_book: { book_id: @cart_book.book_id, cart_id: @cart_book.cart_id }
    end

    assert_redirected_to cart_book_path(assigns(:cart_book))
  end

  test "should show cart_book" do
    get :show, id: @cart_book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart_book
    assert_response :success
  end

  test "should update cart_book" do
    patch :update, id: @cart_book, cart_book: { book_id: @cart_book.book_id, cart_id: @cart_book.cart_id }
    assert_redirected_to cart_book_path(assigns(:cart_book))
  end

  test "should destroy cart_book" do
    assert_difference('CartBook.count', -1) do
      delete :destroy, id: @cart_book
    end

    assert_redirected_to cart_books_path
  end
end
