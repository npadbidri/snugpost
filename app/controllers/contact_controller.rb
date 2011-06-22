class ContactController < ApplicationController
  def index
    
  end
  def sendemail
    if params[:link1]!=""
      Link.create(:link=>params[:link1],:status=>0,:parsed=>0)
    end
    if params[:link2]!=""
      Link.create(:link=>params[:link2],:status=>0,:parsed=>0)
    end
    if params[:link3]!=""
      Link.create(:link=>params[:link3],:status=>0,:parsed=>0)
    end
    error=''
    if params[:name]==""
      error="You must enter your name."
    end
    if params[:email]==""
      error="You must enter your email."
    end
    if params[:subject]==""
      error="You must enter your subject."
    end
    if params[:message]==""
      error="You must enter your message."
    end
    if error!=''
      #salji mail
      data=params
       if Emailer.deliver_contact(data)
        return if request.xhr?
        flash[:notice]="Your email has been successfully sent."
         redirect_to(:controller=>'site')
       else
         flash[:alert]="There's been an error while sending you email."
         redirect_to(:controller=>'site')
       end      
    else
      flash[:alert]=error
      redirect_to(:controller=>'contact')
    end
  end
end
