class BooksController < ApplicationController
  def create
    @new_book = Book.new(book_params)
    @logging_in_user = current_user
    @new_book.user_id = @logging_in_user.id

    if @new_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @logging_in_user = current_user
    @new_book = Book.new
    @books = Book.all
  end

  def show
    # @user = User.find(params[:user_id])
    @new_book = Book.new
    @new_book_comment = BookComment.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])

    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
