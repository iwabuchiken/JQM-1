require 'utils2'
require 'net/ftp'

require "uri"
require "net/http"

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

    write_log(
                  @log_path,
                  "params[:env_nr4][:history_pagination_size]
                     => #{params[:env_nr4][:history_pagination_size]}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
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
        
        # @message = get_index_array(3, 5)
        # @message = get_index_array(20, 5)
        # @message = get_index_array(10, 2)
        # @message = "DONE"
        
        # Count time
        start = Time.now
        
        keywords = Keyword.all
        
        # num = 0
        num = keywords.size
        
        # if keywords.size > 10
#           
          # num = 10
#           
        # else
#           
          # num = keywords.size
#           
        # end
        
        remote_url = "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add"
        
        #attr = "name"
        
        count = 0
        
        # Thread array
        threads = []
        
        num.times do |i|
            # Get docs
            threads << Thread.start(i, remote_url) do
                
                params = _backup_db__build_params(keywords[i])
                
#                attr = "name"
#                
#                key = "data[Keyword][#{attr}]"
#                
#                val = keywords[i].name
#                
#                params = {key => val}
                
              
                x = Net::HTTP.post_form(
                        URI.parse(remote_url),
                        params)
                        
                count += 1
                
            end
            
            # Join
            threads.each do |t|
                t.join
            end
          
          
            
        end
        
        now = Time.now
        
        sec = (now - start).to_int
        
        #REF millseconds http://stackoverflow.com/questions/9173696/split-float-into-integer-and-decimals-in-ruby answered Feb 7 '12 at 9:29
        mil = (now - start) % 1
        
        @message = "Done => #{count.to_s} item(s)(#{sec} seconds #{mil} millseconds)"
        
        write_log(
                  @log_path,
                  "Done => #{count.to_s} item(s)(#{sec} seconds #{mil} millseconds)",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        
        render :layout => 'layouts/nr4/backup_db'
        # render :template => 'nr4/env_nr4s/backup_db'
        
    end

    def _backup_db__build_params(kw)
        # Name
        params = {}
        
        attrs = [
                    "name", "genre_id", "category_id",
                    "remote_id", "created_at", "updated_at"]
        
        values = [
                    kw.name, kw.genre_id, kw.category_id,
                    kw.id, kw.created_at, kw.updated_at]
        
        attrs.size.times do |i|
            
            #REF add element http://www.rubylife.jp/ini/hash/index5.html
            params["data[Keyword][#{attrs[i]}]"] = values[i]
        
        end

        return params
        
    end#_backup_db__build_params
    
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

    def get_index_array(target=10, unit =2)
        
        cycle = target / unit
        residue = target % unit
        
        # write_log(
                  # @log_path,
                  # "cycle=#{cycle}/residue=#{residue}",
                  # # __FILE__,
                  # __FILE__.split("/")[-1],
                  # __LINE__.to_s)
        
        result = []
        
        if cycle < 1
            
            result.push(0..(target - 1))
            # result.push(0..residue)
            
        else#if cycle < 1
            
            num = 0
            
            cycle.times do |i|
                
                result.push(num..(num + (unit - 1)))
                
                num += unit
                
            end
            
            # write_log(
                  # @log_path,
                  # "result=#{result}/residue=#{residue}",
                  # # __FILE__,
                  # __FILE__.split("/")[-1], __LINE__.to_s)
            
            if residue > 0
                
                # write_log(
                      # @log_path,
                      # "Now num is => #{num}",
                      # # "Now num is => #{num}/len(target)=#{len(target)}",
                      # # __FILE__,
                      # __FILE__.split("/")[-1], __LINE__.to_s)
                      
                result.push(num..(target - 1))
                # result.push(num..(len(target) - 1))
                
            # else#if residue > 0
#                 
                # write_log(
                      # @log_path,
                      # "(residue > 0) => false",
                      # # __FILE__,
                      # __FILE__.split("/")[-1], __LINE__.to_s)
#                       
                # result.push(num..(target - 1))
                # # result.push(num..(len(target) - 1))
                
            end#if residue > 0
            
        end#if cycle < 1
        
        return result
        
    end#get_index_array(target=10, unit =2)

end
