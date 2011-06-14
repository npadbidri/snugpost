class Admin < ActiveRecord::Base
  def Admin.can_save_info(username,id)
    t=Admin.find_by_sql("select count(*) num from admins where username='"+username+"' and id<>"+id.to_s)
    return (t[0].num.to_i>0)
  end
  def Admin.admin_exists(username)
    t=Admin.find_by_sql("select count(*) num from admins where username='"+username+"'")
    return (t[0].num.to_i>0)
  end
end
