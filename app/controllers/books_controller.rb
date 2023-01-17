class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id) #本当はbookの詳細画面に飛びたい
    else
    @books = Book.all
    @user = current_user
    render :index
    end
  end


  def index
    @book = Book.new
    @books = Book.all #@user.post_images　ユーザー全ての投稿が見れる場所に飛ばす。15章みて
    @users = User.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully"
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user_id = book.user_id
    unless user_id == current_user.id
      redirect_to book.user
    end
  end


end
