class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model, @content, @method)
  end


  private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        @user = User.where(name: content)
      elsif method == 'forward'
        @user =User.where('name LIKE ?', content+'%')
      elsif method == 'backward'
        @user = User.where('name LIKE ?', '%'+content)
      else
        @user = User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'book'
      if method == 'perfect'
        @book = Book.where(title: content)
      elsif method == 'forward'
        @book = Book.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        @book = Book.where('title LIKE ?', '%'+content)
      else
        @book = Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end

end
