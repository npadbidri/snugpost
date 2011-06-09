class SearchController < ApplicationController
  def index
    @rows=Post.search_by_keyword(params[:search])
  end
end
