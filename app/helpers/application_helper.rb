module ApplicationHelper
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
