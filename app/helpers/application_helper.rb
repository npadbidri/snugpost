module ApplicationHelper
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
  def has_error_msg()
    t=session[:error]
    return (t!=nil)
  end
  def has_info_msg()
    t=session[:info]
    return (t!=nil)
  end
  def isAdminLogged()
    t=session[:AdminData]
    return (t!=nil)
  end
  def getLoggedAdmin()
    session[:AdminData]   
  end
end
