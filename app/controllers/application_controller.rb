class ApplicationController < ActionController::Base
  protect_from_forgery
    def checkLogin
      if (!isAdminLogged())
         redirect_to(:controller => "adminlogin")
      end
    end
    def getErrorMsg()
    result = session[:error]
    session[:error]=nil;
    return result
  end
  def setErrorMsg(msg)
    session[:error]=msg;
    return msg
  end
  def getInfoMsg()
    result = session[:info]
    session[:info]=nil;
    return result
  end
  def setInfoMsg(msg)
    session[:info]=msg;
    return msg
  end
  # za admin dio
  def adminlogin(username)
    @t=Admin.find_by_username(username)
    session[:AdminData]=@t
  end
  def adminlogout()
    session[:AdminData]=nil
  end
  def isAdminLogged()    
    t=session[:AdminData]
    return (t!=nil)
  end
  def getLoggedAdmin()
    session[:AdminData]   
  end
end
require 'rexml/document'
require 'net/http'
#require 'open-uri'
class ParseRss
	def initialize(url)
		@url = url
	end
	def parse
	@content = Net::HTTP.get(URI.parse(@url))
#  reader = Nokogiri::XML::Reader(@content)
  # doc = Nokogiri::XML(@content)
		xml = REXML::Document.new(@content)
	
		#data['title'] = xml.root.elements['channel/title'].text
		#data['home_url'] = xml.root.elements['channel/link'].text
		#data['rss_url'] = @url
    data=[]
    xml.elements.each('//item') do |item|
			it = {}
			it[:title] = item.elements['title'].text
			it[:link] = item.elements['link'].text
			it[:description] = item.elements['description'].text
			if item.elements['dc:creator']
				it[:author] = item.elements['dc:creator'].text
      else
        it[:author] = ""
			end
      if item.elements['media:thumbnail']        
        it[:image] = item.elements['media:thumbnail'].attributes['url']
      else
        it[:image] = ""
			end
			if item.elements['dc:date']
				it[:publication_date] = item.elements['dc:date'].text
			elsif item.elements['pubDate']
				it[:publication_date] = item.elements['pubDate'].text
			end
			data << it
		end
		data		
	end
end