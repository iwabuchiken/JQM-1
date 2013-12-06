require 'utils2'
require 'net/ftp'

require "uri"
require "net/http"

require "csv"
require "socket"

require 'fileutils'

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

    def ___backup_db
        
        f = File.join(_backup_path, "Keyword_backup.csv")
        
        _download_file(f)
        
    end

    def backup_db
        #=============================
        # Steps
        # => Dir exists?
        # => Get an array of classes
        # => Hash of {class => {column names}}
        # => Create files
        # => FTP the files
        #=============================
        
        msg = ""
        
        # => Dir exists?
        backup_path = _backup_path
        
        if !File.exists?(backup_path)
            
            #REF http://stackoverflow.com/questions/3686032/how-to-create-directories-recursively-in-ruby answered Sep 10 '10 at 15:49
            FileUtils.mkpath backup_path
            
            msg += "Dir created: #{backup_path}<br/>"
            
        else
            
            msg += "Dir exists: #{backup_path}<br/>"
            
        end
        
        # => Get an array of classes
        class_names = [Genre, Category, Keyword]
        
        # => Hash of {class => {column names}}
        class_and_columns = _backup_db__get_columns(class_names)
        
        # => Create files
        #REF File.join http://stackoverflow.com/questions/597488/how-to-do-a-safe-join-pathname-in-ruby answered Feb 28 '09 at 4:33
        # msg += File.join(_backup_path, class_and_columns[0].to_s, "_backup.csv")
        # msg += File.join(_backup_path, "#{class_names[0].to_s}_backup.csv")   # => Working
        # msg += File.join(_backup_path, "#{class_and_columns.keys.first.table_name.singularize.capitalize}_backup.csv")
        # msg += "<br/>"
        _backup_db__create_backup_files(class_and_columns)
        
        write_log(
                  @log_path,
                  Dir.glob("#{_backup_path}/*"),
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
        write_log(
                  @log_path,
                  class_names.collect{|x| x.table_name.singularize.capitalize},
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
        
        # => FTP the files
        _backup_db__ftp_files(
                 class_names.collect{
                     |x| x.table_name.singularize.capitalize
                 })
        
=begin
        tmp = Dir.glob("app/models/*.rb")
        
        class_names = []
        
        tmp.each do |x|
            
            #REF extension https://www.ruby-forum.com/topic/179524 2009-02-24 00:03
            class_names.push(File.basename(x, File.extname(x)).classify.constantize)
            # class_names.push(File.basename(x))
            
        end
=end
        #msg += "classes => #{class_names}"
        #msg += "class_and_columns => #{class_and_columns}"
        
        msg += "<br/>"
        
        msg += "Backup db done(Server=#{Socket.gethostname}
                     /URL=#{request.host})"
        
        render :text => msg
                    
        
=begin
        #REF http://www.funonrails.com/2012/01/get-models-list-inside-rails-app.html
        #REF Rails.root https://github.com/veerasundaravel/Facebook-Registration/issues/1 apmomp commented
        Dir.glob(Rails.root + '/app/models/*.rb').each { |file| require file }
        # Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }
        
        # class_names = Dir.glob("app/models/*")
        # class_names = Dir.glob("app/models/*.rb")
        # class_names = Dir.glob("app/models/*.rb").each{|name| "abc"}
        tmp = Dir.glob("app/models/*.rb")
        
        class_names = []
        
        tmp.each do |x|
            
            #REF basename http://docs.ruby-lang.org/ja/1.8.7/method/File/s/basename.html
            # class_names.push(File.basename(x).classify.constantize)
            
            #REF extension https://www.ruby-forum.com/topic/179524 2009-02-24 00:03
            class_names.push(File.basename(x, File.extname(x)).classify.constantize)
            # class_names.push(File.basename(x))
            
        end
        
        # class_names = File.basename(tmp[0])
        # class_names = tmp[0].class.to_s   # => String
        # class_names = tmp.each{|elem| elem.split("/")[-1]}
        # class_names = tmp.each{|elem| File.basename(elem)}
        # class_names = File.basename("app/models/a.rb")
        # class_names = tmp.class.to_s
        # class_names = Dir.glob(Rails.root + '/app/models/*.rb')
        
        class_Keyword = "keywords".singularize.classify.constantize
        
        # models = [class_Keyword, Genre]
        models = [Keyword, Genre]
        
        classes = Module.constants
        
        #REF http://stackoverflow.com/questions/516579/is-there-a-way-to-get-a-collection-of-all-the-models-in-your-rails-app answered Feb 5 '09 at 16:17
        # classes = Module.constants.select { |c| (eval c).is_a? Class }
        
        # class_names = classes.map{|c| c.to_s}
        # class_names = ActiveRecord::Base.send(:classes)   # => undefined method `classes' for ActiveRecord::Base:Class
        
        #REF http://www.funonrails.com/2012/01/get-models-list-inside-rails-app.html
        # class_names = ActiveRecord::Base.send(:subclasses)
        # class_names = ActiveRecord::Base.send(:subclasses).collect(&:name)
        
        # fpath = "tmp/backup/backup_#{models[0].to_s}.csv"
        fpath = "tmp/backup_#{models[0].to_s}.csv"
        
        #REF table_name http://stackoverflow.com/questions/6139640/how-to-determine-table-name-within-a-rails-3-model-class answered May 26 '11 at 14:12
        table_info = [models[0].to_s, models[0].table_name]
        # table_info = ["Keyword", "keywords"]
        
        #REF http://stackoverflow.com/questions/3479551/how-to-get-an-array-with-column-names-of-a-table answered Aug 14 '10 at 9:17
        columns = Keyword.columns.map{|c| c.name}
        
        kws = models[0].all
        # kws = Keyword.all
        
        values = []
        
        kws.each do |k|
            
            value = []
            
            columns.each do |c|
                
                value.push(k[c])
                
            end
            
            values.push(value)
            
        end#kws.each do |k|
        
        CSV.open(fpath, 'w') do |w|
            
            w << table_info
            w << columns
            
            values.each do |v|
                
                w << v
                
            end
            
        end#CSV.open(fpath, 'w') do |w|
        
        
        # kw = Keyword.first
#         
        # values = []
#         
        # columns.each do |c|
#             
            # values.push(kw[c])
#             
        # end
#         
        # # values = kw.methods.sort
        # # values = [kw[columns[0]], kw[columns[1]]]
#         
        # # values = Keyword.public_constant.methods.sort
        # # values = Keyword.methods.sort
#         
        # #REF http://libro.tuyano.com/index3?id=1102003&page=3
        # CSV.open(fpath, 'w') do |writer|
            # writer << table_info
            # writer << columns
            # writer << values
#             
            # # values.each do |v|
# #                 
                # # value = [v]
                # # writer << value
                # # # writer << v
# #             
            # # end
#             
        # end
=end

        #REF hostname http://stackoverflow.com/questions/7154914/how-to-get-host-name-in-rails-3 answered Aug 23 '11 at 0:34
        # render :text =>
                    # "Backup db (Server=#{Socket.gethostname}\
                     # /URL=#{request.host})/class_names = #{class_names[0].to_s + 123.to_s}"
                     # # /URL=#{request.host})/class_names = #{class_names}"
                    # # /URL=#{request.host})/class_Keyword.class.to_s = #{class_Keyword.class.to_s}"
      
      
=begin
        # # @message = get_index_array(3, 5)
        # # @message = get_index_array(20, 5)
        # # @message = get_index_array(10, 2)
        # # @message = "DONE"
#         
        # # Count time
        # start = Time.now
#         
        # keywords = Keyword.all
#         
        # # num = 0
        # num = keywords.size
#         
        # # if keywords.size > 10
# #           
          # # num = 10
# #           
        # # else
# #           
          # # num = keywords.size
# #           
        # # end
#         
        # remote_url = "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add"
#         
        # #attr = "name"
#         
        # count = 0
#         
        # # Thread array
        # threads = []
#         
        # num.times do |i|
            # # Get docs
            # threads << Thread.start(i, remote_url) do
#                 
                # params = _backup_db__build_params(keywords[i])
#                 
# #                attr = "name"
# #                
# #                key = "data[Keyword][#{attr}]"
# #                
# #                val = keywords[i].name
# #                
# #                params = {key => val}
#                 
#               
                # x = Net::HTTP.post_form(
                        # URI.parse(remote_url),
                        # params)
#                         
                # count += 1
#                 
            # end
#             
            # # Join
            # threads.each do |t|
                # t.join
            # end
#           
#           
#             
        # end
#         
        # now = Time.now
#         
        # sec = (now - start).to_int
#         
        # #REF millseconds http://stackoverflow.com/questions/9173696/split-float-into-integer-and-decimals-in-ruby answered Feb 7 '12 at 9:29
        # mil = (now - start) % 1
#         
        # @message = "Done => #{count.to_s} item(s)(#{sec} seconds #{mil} millseconds)"
#         
        # write_log(
                  # @log_path,
                  # "Done => #{count.to_s} item(s)(#{sec} seconds #{mil} millseconds)",
                  # # __FILE__,
                  # __FILE__.split("/")[-1],
                  # __LINE__.to_s)
# 
#         
        # render :layout => 'layouts/nr4/backup_db'
        # # render :template => 'nr4/env_nr4s/backup_db'
=end

    end#backup_db

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

    def _backup_path
        
        return "doc/backup/nr4"
        
    end

    def _backup_db__get_columns(class_names)
        
        res = {}
        
        class_names.each_with_index do |x, i|
            
            columns = class_names[i].columns.map{|c| c.name}
            
            res[class_names[i]] = columns
        
        end
        
        return res
        
    end#_backup_db__get_columns

    ################################################
    # => _backup_db__create_backup_files(class_and_columns)
    # => @param
    # =>    class_and_columns
    # =>        {Keyword => ["id", "name", ...], Genre => ...}
    ################################################
    def _backup_db__create_backup_files(class_and_columns)
        
        models = class_and_columns.keys
        
        models.each do |m|
            
            columns = class_and_columns[m]
        
            #REF table_name http://stackoverflow.com/questions/6139640/how-to-determine-table-name-within-a-rails-3-model-class answered May 26 '11 at 14:12
            table_info = [m.to_s, m.table_name]

            t = Time.now
            
            # fpath = "tmp/backup/backup_#{models[0].to_s}.csv"
            fpath = File.join(
                        _backup_path,
                        "#{m.table_name.singularize.capitalize}_backup.csv")
            
            CSV.open(fpath, 'w') do |w|
                
                w << table_info
                w << [t]
                # w << t
                w << columns
                
                # data
                entries = m.all
                
                entries.each do |e|
                    
                    data = []
                    
                    columns.each do |c|
                        
                        data.push(e[c])
                        
                    end#columns.each do |c|
                    
                    w << data
                    
                end#entries.each do |e|
                
            end#CSV.open(fpath, 'w') do |w|
            
        end#models.each do |m|
        
=begin
        # fpath = "tmp/backup/backup_#{models[0].to_s}.csv"
        fpath = File.join(
                    _backup_path,
                    "#{class_and_columns.keys.first.\
                            table_name.singularize.capitalize}_backup.csv")
        
        #REF table_name http://stackoverflow.com/questions/6139640/how-to-determine-table-name-within-a-rails-3-model-class answered May 26 '11 at 14:12
        table_info = [
                    class_and_columns.keys.first.to_s,
                    class_and_columns.keys.first.table_name]
                    
        columns = class_and_columns[class_and_columns.keys.first]
                    
        
        CSV.open(fpath, 'w') do |w|
            
            w << table_info
            w << columns
        end#CSV.open(fpath, 'w') do |w|
=end
    end#_create_backup_files(class_and_columns)
    
    def _backup_db__ftp_files(names)
        
        counter = 0
        
        names.each do |n|
        
            f = File.join(_backup_path, "#{n}_backup.csv")
            
            # if !f.exists?
            if !File.exists?(f)
                
                #REF http://stackoverflow.com/questions/4010039/equivalent-of-continue-in-ruby answered Oct 24 '10 at 19:41
                next
                
            end
            
            tmp = File.basename(f).split(".")
            
            new_f = tmp.join("_#{get_time_label_now_2}.")
            
            ftp_url = "ftp.benfranklin.chips.jp"
            
            uname = "chips.jp-benfranklin"
            
            passwd = "9x9jh4"
            
            ftp_dir = "/rails_apps/nr4/db"
            
            # return temp_array.join("_#{get_time_label_now_2}.")
            
            # return file_path
            
            task = Net::FTP.open(ftp_url) do |ftp|
                
                ftp.login(uname, passwd)
                
                ftp.chdir(ftp_dir)
                
                ftp.put(f, new_f)
                
                counter += 1
                
            end#task = Net::FTP.open('ftp.benfranklin.chips.jp') do |ftp|
        
        end#names.each do |n|
        
        write_log(
                  @log_path,
                  "Files ftp-ed => #{counter.to_s} item(s)",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
        
    end#_backup_db__ftp_files(names)
        
    
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

    def _download_file(fullpath)
        
        #REF http://qiita.com/akkun_choi/items/64080a8e17930879b4da
        
        stat = File::stat(fullpath)
        
        send_file(fullpath,
            :filename => File.basename(fullpath),
            :length => stat.size)
        
    end

end
