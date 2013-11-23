require 'utils2'

class Nr4::EnvNr4sController < ApplicationController
    
    layout 'layouts/nr4/genres'

    #REF http://maskana-soft.com/rails/pro/body/41
    before_filter :log_path
    
  # GET /env_nr4s
  # GET /env_nr4s.json
  def index
      
      
      
    @env_nr4s = EnvNr4.all
    
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @env_nr4s }
    end
  end
  
  # GET /env_nr4s/1
  # GET /env_nr4s/1.json
  def show
    @env_nr4 = EnvNr4.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @env_nr4 }
    end
  end

  # GET /env_nr4s/new
  # GET /env_nr4s/new.json
  def new
    @env_nr4 = EnvNr4.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @env_nr4 }
    end
  end

  # GET /env_nr4s/1/edit
  def edit
    @env_nr4 = EnvNr4.find(params[:id])
  end

  # POST /env_nr4s
  # POST /env_nr4s.json
  def create
    @env_nr4 = EnvNr4.new(params[:env_nr4])

    respond_to do |format|
      if @env_nr4.save
        format.html { redirect_to @env_nr4, notice: 'Env nr4 was successfully created.' }
        format.json { render json: @env_nr4, status: :created, location: @env_nr4 }
      else
        format.html { render action: "new" }
        format.json { render json: @env_nr4.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /env_nr4s/1
  # PUT /env_nr4s/1.json
  def update
    @env_nr4 = EnvNr4.find(params[:id])
    
    if @env_nr4.genre_id.to_s == ""
        
        write_log(
                  @log_path,
                  "@env_nr4.genre_id => \"\"(class=#{@env_nr4.genre_id.class.to_s})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    elsif @env_nr4.genre_id.to_s == nil
    
        write_log(
                  @log_path,
                  "@env_nr4.genre_id => nil(class=#{@env_nr4.genre_id.class.to_s})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    else
        
        write_log(
                  @log_path,
                  "@env_nr4.genre_id=#{@env_nr4.genre_id.to_s}(class=#{@env_nr4.genre_id.class.to_s})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    end

    respond_to do |format|
      if @env_nr4.update_attributes(params[:env_nr4])
        format.html { redirect_to @env_nr4, notice: 'Env nr4 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @env_nr4.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /env_nr4s/1
  # DELETE /env_nr4s/1.json
  def destroy
    @env_nr4 = EnvNr4.find(params[:id])
    @env_nr4.destroy

    respond_to do |format|
      format.html { redirect_to env_nr4s_url }
      format.json { head :no_content }
    end
  end
  
    def show_category_list
        
        
        @selected_genre = params[:selected_genre]
        
        # @categories = Category.find(\
                            # :all,
                            # :conditions => {:genre_id => @genre})
        
        # layout 'layouts/nr4/keywords/show_genre_list'
        #REF http://www.rubylife.jp/rails/template/index3.html#section3
        # render :layout => 'layouts/env_nr4s/show_genre_list'
        render :layout => 'layouts/nr4/keywords/show_genre_list'
        

    end#show_genre_list

  
private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end

end