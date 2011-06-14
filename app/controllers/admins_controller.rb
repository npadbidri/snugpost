class AdminsController < ApplicationController
  layout 'admin'
  before_filter:checkLogin  

  def logout
    adminlogout()
    redirect_to(:controller => "adminlogin")
  end
  def index
    @rows=Link.all()
    respond_to do |format|
      format.html # index.html.erb      
    end
  end
  def listlinks
    redirect_to(:controller=>"links")
  end
  def account
    @admin=getLoggedAdmin()
  end
  def saveaccount
    @admin=getLoggedAdmin()
    if Admin.can_save_info(params[:username],@admin.id)
      setErrorMsg("There's already an administrator with the same given username.")
      redirect_to(:controller=>"admins",:action=>"account")
    else
     if (params[:oldpassword]!="" && Digest::SHA1.hexdigest(params[:oldpassword])!=@admin.password)
      setErrorMsg("Old password is incorrect.")
      redirect_to(:controller=>"admins",:action=>"account")
     else
       if params[:password]!=""
         @admin.password=Digest::SHA1.hexdigest(params[:password])
       end
       @admin.username=params[:username]
       Admin.update(@admin.id,:username => @admin.username,:password=>@admin.password)
       adminlogin(@admin.username)
       setInfoMsg("Your information is successfully saved.")
       redirect_to(:controller=>"admins",:action=>"show")
     end
    end
  end
  # GET /admins/1
  # GET /admins/1.xml
  def show
    @rows = Admin.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    if Admin.admin_exists(params[:username])
      setErrorMsg("There's already an administrator with the same given username.")
      redirect_to(:controller=>"admins",:action=>"new")
    end
    Admin.create(:username=>params[:username],:password=>Digest::SHA1.hexdigest(params[:password]))
    setInfoMsg("Administrator is saved successfully.")
    redirect_to(:controller=>"admins",:action=>"show")
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])
    if Admin.can_save_info(params[:username],@admin.id)
      setErrorMsg("There's already an administrator with the same given username.")
      redirect_to(:controller=>"admins",:action=>"edit",:id=>@admin.id)
    end
    if (params[:password]!="")
      @admin.password=Digest::SHA1.hexdigest(params[:password])
    end
    Admin.update(@admin.id,:username => @admin.username,:password=>@admin.password)
    setInfoMsg("Administrator is saved successfully.")
    redirect_to(:controller=>"admins",:action=>"show")
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @l=getLoggedAdmin()
    @admin = Admin.find(params[:id])
    if @l.id==@admin.id
      setErrorMsg("You cannot delete yourself")
    else
      @admin.destroy
      setInfoMsg("Administrator has been deleted successfully.")
    end
    redirect_to(:controller=>"admins",:action=>"show")
  end
end
