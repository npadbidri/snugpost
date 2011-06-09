class SiteController < ApplicationController  
  def index
    @rows=Post.getLatest
  end
end
