class AdminsController < ApplicationController
  layout 'admin'
  before_filter:checkAdminLogin
  def logout
    redirect_to(destroy_user_session_path)
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
    if Admin.can_save_info(params[:email],@admin.id)
      flash[:alert]="There's already an administrator with the same given email."
      redirect_to(:controller=>"admins",:action=>"account")
    else    
       @admin.email=params[:email]
       if (params[:password]!="")
          @admin.password=params[:password]
          User.update(@admin.id,:email => @admin.email,:password=>@admin.password,:password_confirmation =>@admin.password)
       else
        User.update(@admin.id,:email => @admin.email)
       end
       flash[:notice]="Your information is successfully saved."
       redirect_to(:controller=>"admins",:action=>"show")
     end    
  end
  # GET /admins/1
  # GET /admins/1.xml
  def show
    @rows = User.all
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
    @admin = User.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    if Admin.admin_exists(params[:email])
      flash[:alert]="There's already an administrator with the same given email."
      redirect_to(:controller=>"admins",:action=>"new")
      return
    end
    u=User.new(:email=>params[:email],:password=>params[:password],:password_confirmation =>params[:password])
    if u.save
      u.update_attribute("is_admin",1)
      flash[:notice]="Administrator is saved successfully."
      redirect_to(:controller=>"admins",:action=>"show")
      return
    else
      flash[:alert]=u.errors
      redirect_to(:controller=>"admins",:action=>"new")
      return
    end    
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = User.find(params[:id])
    if Admin.can_save_info(params[:email],@admin.id)
      flash[:alert]="There's already an administrator with the same given username."
      redirect_to(:controller=>"admins",:action=>"edit",:id=>@admin.id)
    end
    if (params[:password]!="")
      User.update(@admin.id,:email=> params[:email],:password=>params[:password],:password_confirmation =>params[:password])
    else
      User.update(@admin.id,:email=> params[:email])
    end
    flash[:notice]="Administrator is saved successfully."
    redirect_to(:controller=>"admins",:action=>"show")
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @l=getLoggedAdmin()
    @admin = User.find(params[:id])
    if @l.id==@admin.id
      flash[:alert]="You cannot delete yourself"
    else
      @admin.destroy
      flash[:notice]="Administrator has been deleted successfully."
    end
    redirect_to(:controller=>"admins",:action=>"show")
  end
end
