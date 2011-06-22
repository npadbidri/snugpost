class PostsController < ApplicationController
  layout 'admin'
  before_filter:checkAdminLogin
  def index
    @rows = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def delete
    @post = Post.find(params[:id])
    if @post.destroy
      #setInfoMsg("Post is successfully deleted.")
      flash[:notice]="Post is successfully deleted."
      redirect_to(:controller=>"posts")
    else
      flash[:alert]="Post wan not deleted."
      redirect_to(:controller=>"posts")
    end
    #redirect_to(:controller=>"posts",:notice=>"Post is successfully deleted.")
  end
end
