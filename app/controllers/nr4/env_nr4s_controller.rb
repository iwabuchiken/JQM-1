require 'utils2'
require 'net/ftp'


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
    
    @genre = Genre.find(
                :first,
                :conditions => ["id = ?", @env_nr4.genre_id])
                
    @category = Category.find(
                :first,
                :conditions => ["id = ?", @env_nr4.category_id])

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

    def backup_db
        
        @message = ""
        
        # dir = Dir.glob("db")
        # dir = Dir.glob("/db")
        # @dir = Dir.glob(Rails.root.join('db'))
        # @dir = Dir.glob(Rails.root.join('db') + "/*")
        
        #REF http://stackoverflow.com/questions/2983734/rails-auto-detecting-database-adapter answered Jun 6 '10 at 15:38
        # @message = ActiveRecord::Base.configurations[Rails.env]['adapter']
        
        # @message = Dir.glob(Rails.root.join('db', '**', '*'))
        # @message = Dir.glob(Rails.root.join('db', '*'))
        
        db_type = ActiveRecord::Base.configurations[Rails.env]['adapter']
#         
        if db_type == "sqlite3"
            
            @message = _backup_db_sqlite
            
        else
            
            @message = "Other than sqlite3"
            
        end

        
        # render :layout => 'layouts/nr4/keywords/show_genre_list'
        render :layout => 'layouts/nr4/backup_db'
        # render :template => 'nr4/env_nr4s/backup_db'
        
        #REF http://railsdoc.com/references/render
        #render :text => message
        # render :text => "backup_db"
        
    end
    
    def _backup_db_sqlite
        
        file_path = Rails.root.join(
                ActiveRecord::Base.configurations[Rails.env]['database'])
        
        temp_array = File.basename(file_path).split(".")
        
        new_path = temp_array.join("_#{get_time_label_now_2}.")
        
        # return temp_array.join("_#{get_time_label_now_2}.")
        
        # return file_path
        
        task = Net::FTP.open('ftp.benfranklin.chips.jp') do |ftp|
            
            ftp.login('chips.jp-benfranklin','9x9jh4')
            
            ftp.chdir('/rails_apps/nr4/db')
            
            ftp.put(file_path, new_path)
            
            @message = "File ftp-ed => " + file_path.to_s
            
            # write_log(
                  # @log_path,
                  # "login => Done",
                  # # __FILE__,
                  # __FILE__.split("/")[-1],
                  # __LINE__.to_s)

            # message = "Login => Done"
            
            # ftp.list('*.*') { |file| @message += "#{file}<br/>" }
            
        end#task = Net::FTP.open('ftp.benfranklin.chips.jp') do |ftp|
        
    end#_backup_db_sqlite
    
private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end

end
