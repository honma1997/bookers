class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    if @book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # 3. フラッシュメッセージを定義し、new.html.erbを描画する
      flash.now[:notice] = "failed"
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new  
  end

  def show
    @book = Book.find(params[:id])  
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
    
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    flash[:notice] = "Successfully"
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
