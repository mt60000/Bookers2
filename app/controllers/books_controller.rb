class BooksController < ApplicationController
  before_action :authenticate_user!, excect: [:index, :show]

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all
    @books_rank = Book.includes(:favorited_users)
                      .sort {|a,b|
                        b.favorited_users.includes(:favorites).where(created_at: from...to).count <=>
                        a.favorited_users.includes(:favorites).where(created_at: from...to).count
                      }


    # @books_rank = Book.all
    #                   .(Favorite.group(:book_id)
    #                   .where(created_at: from...to)
    #                   .order('count(book_id) desc')
    #                   .pluck(:book_id))
    @book =Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @new_book = Book.new
    @book_user = @book.user
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(params[:id]), notice: 'You have updated book successfully.'
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
    params.require(:book).permit(:title, :body, :user_id)
  end

end
