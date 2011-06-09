class AdminloginController < ApplicationController
  layout 'admin'
  def index
  end
  def auth
    @admin=Admin.find_by_username_and_password(params[:username],Digest::SHA1.hexdigest(params[:password]))
    if @admin
       adminlogin(params[:username])
       redirect_to(:controller => "admins")
    else
      setErrorMsg("Wrong login credentials")
      redirect_to(:controller => "adminlogin")
    end
  end
end
