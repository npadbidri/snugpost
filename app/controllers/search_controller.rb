class SearchController < ApplicationController
  def index
    @rows=Post.search_by_keyword(params[:search],params[:page])
     @yt=ParseRss.new("http://gdata.youtube.com/feeds/api/standardfeeds/most_popular").ParseYoutTube()
  end
end
