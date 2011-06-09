class Link < ActiveRecord::Base
  def Link.accept_link(id)        
    Link.update_all(["status = 1"], ["id= ? ", id])
  end
  def Link.parsed_link(id)
    Link.update_all(["parsed = 1"], ["id= ? ", id])
  end
  def Link.insert_parsed_links(data)
    i=0
    data.each do |row|      
      if Post.create(:title=>row[:title],:description=>row[:description],:link=>row[:link],:author=>row[:author],:image=>row[:image],:publication_date=>row[:publication_date])
        i+=1
      end
    end
    i
  end
end
