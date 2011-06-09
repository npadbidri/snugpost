class LinksController < ApplicationController
  layout 'admin'
  before_filter:checkLogin  
  def index
    @rows = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end
  def accept
    @link=Link.find(params[:id])
    if @link
      Link.accept_link(params[:id])
      setInfoMsg("Link is succesfully accepted")
      redirect_to(:controller=>"links")
    else
      setErrorMsg("Link doesn't exist")
      redirect_to(:controller=>"links")
    end
  end
  def parse
    @link=Link.find(params[:id])
    if @link
      if @link.parsed!=1
       data=ParseRss.new(@link.link).parse()
      t=Link.insert_parsed_links(data)
      if t
        setInfoMsg(t.to_s+' post successfully parsed.')
      end
       Link.parsed_link(@link.id)
       redirect_to(:controller=>"links")
      else
        setErrorMsg("Link is already parsed.")
        redirect_to(:controller=>"links")
      end
    end
  end
  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(@link, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end
end
