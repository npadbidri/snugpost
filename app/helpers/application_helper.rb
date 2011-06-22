module ApplicationHelper
  
  def isAdminLogged()
    t=session[:AdminData]
    return (t!=nil)
  end
  def getLoggedAdmin()
    session[:AdminData]   
  end
end
