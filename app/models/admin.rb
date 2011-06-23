class Admin < ActiveRecord::Base
  def Admin.can_save_info(email,id)
    t=User.find_by_sql("select count(*) num from users where email='"+email+"' and id<>"+id.to_s)
    return (t[0].num.to_i>0)
  end
  def Admin.admin_exists(email)
    t=User.find_by_sql("select count(*) num from users where email='"+email+"'")
    return (t[0].num.to_i>0)
  end
end
