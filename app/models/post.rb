class Post < ActiveRecord::Base
  def Post.getLatest(limit=8)
    self.find_by_sql("select * from posts order by publication_date desc limit "+limit.to_s)
  end
  def Post.search_by_keyword(key,page)
    sql="select * from posts where title like '%"+key.to_s+"%' order by publication_date desc"
    Post.find_by_sql(sql).paginate(:page => page,:per_page=>PER_PAGE)
  end
end
