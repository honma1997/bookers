class ListsController < ApplicationController

  def create
    @list = List.new(list_params)
    if @list.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "successfully"
      redirect_to list_path(@list.id)
    else
      # 3. フラッシュメッセージを定義し、new.html.erbを描画する
      flash.now[:notice] = "failed"
      @lists = List.all
      render :index
    end
  end

  def index
    @lists = List.all
    @list = List.new  
  end

  def show
    @list = List.find(params[:id])  
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      flash[:notice] = "Successfully"
      redirect_to list_path(@list.id)
    else
      flash.now[:notice] = "failed."
      render :edit
    end
    
  end

  def destroy
    list = List.find(params[:id])  # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    flash[:notice] = "Successfully"
    redirect_to '/lists'  # 投稿一覧画面へリダイレクト  
  end

  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body)
  end

end
