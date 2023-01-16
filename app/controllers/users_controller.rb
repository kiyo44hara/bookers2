class UsersController < ApplicationController
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to users_path #のちにユーザー専用のindexに飛ばす
    else
    render :new
    end
  end
  
  
  def index
    @users = User.all
    @books = Book.all
    @user = current_user
    @books = @user.books
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to users_path
    else
      render :index
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to books_path
    end
  end
end
