class PostsController < ApplicationController
  layout 'admin'
  before_filter:checkLogin
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
      setInfoMsg("Post is successfully deleted.")
    end
    redirect_to(:controller=>"posts")
  end
end
