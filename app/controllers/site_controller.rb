class SiteController < ApplicationController  
  def index
    @rows=Post.getLatest(12)
    @yt=ParseRss.new("http://gdata.youtube.com/feeds/api/standardfeeds/most_popular").ParseYoutTube()
  end
end
