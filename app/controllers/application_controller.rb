class ApplicationController < ActionController::Base
  protect_from_forgery

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  def checkAdminLogin
      if user_signed_in?
        if (current_user.is_admin==0)
          flash[:alert]="You must be logged in as an Administrator"
           redirect_to(user_session_path)           
        end
      else
        flash[:alert]="You must be logged in as an Administrator"
        redirect_to(user_session_path)
      end
  end
  # za admin dio

  def isAdminLogged()    
    if user_signed_in?
       return current_user.is_admin==1
    else
      return false
    end
  end
  def getLoggedAdmin()
    current_user
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
  def ParseYoutTube
    @content = Net::HTTP.get(URI.parse(@url))
#  reader = Nokogiri::XML::Reader(@content)
  # doc = Nokogiri::XML(@content)
		xml = REXML::Document.new(@content)

		#data['title'] = xml.root.elements['channel/title'].text
		#data['home_url'] = xml.root.elements['channel/link'].text
		#data['rss_url'] = @url
    data=[]
    xml.elements.each('//entry') do |item|
			it = {}
      it[:title] =item.elements['title'].text
			it[:link] =item.elements['link'].attributes['href'].sub("&feature=youtube_gdata","")
			data << it
		end
		data
  end
end