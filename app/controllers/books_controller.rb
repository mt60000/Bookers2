class BooksController < ApplicationController
  before_action :authenticate_user!, excect: [:index, :show]

  def index
    to = Time.current
    from = to.ago(7.days)
    @books = Book.includes(:favorited_users)
                      .sort {|a,b|
                        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
                        a.favorited_users.includes(:favorites).where(created_at: from...to).size
                      }
    @book =Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @new_book = Book.new
    @book_user = @book.user
    @user = @book.user
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |current_user|
        @user_entry.each do |user|
          if current_user.room_id == user.room_id then
            @is_room = true
            @room_id = current_user.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
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
