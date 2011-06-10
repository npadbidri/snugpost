class Emailer < ActionMailer::Base
  default :from => SITE_EMAIL,:return_path => SITE_EMAIL

  def contact(data)
    @info=data    
  end

end
