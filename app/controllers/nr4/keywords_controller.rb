#encoding: utf-8
require 'utils2'

class Nr4::KeywordsController < ApplicationController
  # GET /keywords
  # GET /keywords.json
  
  layout 'layouts/nr4/genres'
  
  #REF http://maskana-soft.com/rails/pro/body/41
  before_filter :log_path


  def index
      #debug
      if @log_path == nil
            @log_path = log_path
      end
      
        write_log(
                  @log_path,
                  "keywords#index",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

    #----------------------
    # Filter
    #----------------------
    # @keywords = Keyword.all
    @keywords = _index__1_filter()
    # _index__2_filter(params['filter'])
        
    #----------------------
    # @genres
    #----------------------
    @genres = Genre.all
    
    #----------------------
    # @categories
    #----------------------
    @categories = Category.all
    
    #----------------------
    # Get: Articles models list
    #----------------------
    if params['sort']
        
        _index__1_sort(params['sort'])
      
    else
        
        #debug
        write_log(
                  @log_path,
                  "sort => nil",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    end    
    
    
              
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end
  
    def _index__1_filter()
        
        filter_genre = 
                _index__1_filter_get_genre()
        
        filter_categories =
                _index__1_filter_get_categories(filter_genre)
        
        write_log(
                      @log_path,
                      "filter_categories => 
                            #{filter_categories}(class=#{filter_categories.class.to_s})",
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)
        
        # Get: keywords
        
        if filter_genre != nil
            
            # filter_categories = Category.find(
                        # :all,
                        # :conditions => ["genre_id = ?", filter_genre])

            # => If the length of filter_categories is one or less than one,
            # =>    then just build a keywords list using only filter_genre
            # =>    value.
            if filter_categories == nil or filter_categories.length < 1
                
                keywords = Keyword.find(
                      :all,
                      :conditions => ["genre_id = ?", filter_genre])
                      
            elsif filter_categories.length == 1
                
                keywords = Keyword.find(
                      :all,
                      :conditions => ["genre_id = ? and category_id = ?", filter_genre, filter_categories[0]])
                      
            else
                
                keywords = Keyword.find(
                      :all,
                      :conditions => ["genre_id = ?", filter_genre])
                      
                
                sql = _index__1_filter_Build_SQL(
                                filter_genre,
                                filter_categories)
                
                write_log(
                      @log_path,
                      "sql => #{sql}",
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)
                      
            end

        else
            
            keywords = Keyword.all
            
        end
        
        write_log(
                  @log_path,
                  "keywords=#{keywords}(size=#{keywords.size})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        
        return keywords
        
    end#_index__1_filter()

    def _index__1_filter_Build_SQL(filter_genre,filter_categories)
        
        sql = []
        temp = []
        statement = ""
        
        temp.push("genre_id = ? and")
        temp.push("category_id = ?")
        
        ((filter_categories.length) - 1).times {
            
            temp.push(" or category_id = ?")
            
        }
        
        statement = temp.join(" ")
        
        sql.push(statement)
        sql.push(filter_genre)
        
        filter_categories.length.times {|i|
            
            sql.push(filter_categories[i])
            
        }
        
        # sql = sql + filter_categories.collect{|cat| cat.name}
            
        #debug
        write_log(
                  @log_path,
                  "sql=#{sql.flatten}(class=#{sql.flatten.class.to_s})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
        
        return sql.join(" ")
        
    end#_index__1_filter_Build_SQL()

    def _index__1_filter_get_genre()  
    
                # Get: filter_genre
        _filter_genre = params['filter_genre']
        
        #debug
        if _filter_genre == ""
            # write_log(
                      # @log_path,
                      # "_filter_genre => \"\"",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)        
#                       
         elsif _filter_genre == nil
            # write_log(
                      # @log_path,
                      # "_filter_genre => nil",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)
         else
             # write_log(
                      # @log_path,
                      # "_filter_genre => ?(value=#{_filter_genre})",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)
#         
         end
        
        if _filter_genre != nil
            
            filter_genre = _filter_genre
            
            # #debug
            # write_log(
                      # @log_path,
                      # "_filter_genre != nil",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)
            
        elsif EnvNr4.first != nil and EnvNr4.first.genre_id != nil
        # elsif EnvNr4.first != nil and EnvNr4.first.genre_id = nil
            
            # #debug
            # write_log(
                      # @log_path,
                      # "EnvNr4.first != nil and EnvNr4.first.genre_id != nil",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)
            
            filter_genre = EnvNr4.first.genre_id
            
        else
            # #debug
            # write_log(
                      # @log_path,
                      # "_filter_genre => else",
                      # # __FILE__,
                      # __FILE__.split("/")[-1],
                      # __LINE__.to_s)
            
            filter_genre = nil
            
        end
        
            #debug
            write_log(
                      @log_path,
                      "filter_genre => #{filter_genre}",
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)
            
        return filter_genre
        
    end#_index__1_filter_get_genre
    
    #########################################
    # _index__1_filter_get_categories(filter_genre)
    # Return => Array<String>
    #########################################
    def _index__1_filter_get_categories(filter_genre)
        
        filter_categories = []
        
        if filter_genre != nil
                            # Get: filter_genre
            _filter_category = params['filter_category']
            
            if _filter_category != nil
                
                filter_categories.push(_filter_category)
                
                # #debug
                # write_log(
                          # @log_path,
                          # "_filter_genre != nil",
                          # # __FILE__,
                          # __FILE__.split("/")[-1],
                          # __LINE__.to_s)
                
            elsif EnvNr4.first != nil and EnvNr4.first.category_id != nil
            # elsif EnvNr4.first != nil and EnvNr4.first.genre_id = nil
                
                # #debug
                # write_log(
                          # @log_path,
                          # "EnvNr4.first != nil and EnvNr4.first.genre_id != nil",
                          # # __FILE__,
                          # __FILE__.split("/")[-1],
                          # __LINE__.to_s)
                
                filter_categories.push(EnvNr4.first.category_id)
                
            else
                # #debug
                # write_log(
                          # @log_path,
                          # "_filter_genre => else",
                          # # __FILE__,
                          # __FILE__.split("/")[-1],
                          # __LINE__.to_s)
                
                filter_categories = nil
                
            end
    
        else#if filter_genre != nil
            
            filter_categories = Category.all.collect{|cat| cat.id}
            
        end
        
            return filter_categories
        
    end#_index__1_filter_get_categories(filter_genre)
    
  # GET /keywords/1
  # GET /keywords/1.json
  def show
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    @keyword = Keyword.new

    @genres = Genre.all
    
    @categories = Category.find(:all, :conditions => {:genre_id => @genres[0].id})
    
    # @categories.sort!
    @categories.sort! do |c1, c2|
           
        c1.name <=> c2.name
            
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/1/edit
  def edit
    @keyword = Keyword.find(params[:id])
  end

  # POST /keywords
  # POST /keywords.json
  def create
  
       log_path
  
       tokens = params[:keyword][:name].gsub(/　/, " ").split()
       
       #debug
        write_log(
                  @log_path,
                  "tokens=#{tokens}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

       
       if tokens.length > 1
            
            tmp = 0
            
            tokens.length.times do |i|
            
                keyword = Keyword.new(params[:keyword])
                
                keyword.name = tokens[i]
                
                
                
                if keyword.save
                    
                    tmp += 1
                    
                    t = Thread.new do
                      
                      msg = _post_data(_get_backup_url, keyword)
                      
                  end
                    
                    # _post_data(remote_url, model)
                    msg = _post_data(Const::BACKUP_URL_NR4_KEYWORDS, keyword)
                    
                    @keyword = keyword
                    
                end
                
            end
            
            respond_to do |format|
                if @keyword != nil
                    format.html { redirect_to @keyword, notice: "Keyword was successfully created => #{tmp.to_s} itetm(s)" }
                    format.json { render json: @keyword, status: :created, location: @keyword }
                else
                    format.html { render action: "new" }
                    format.json { render json: @keyword.errors, status: :unprocessable_entity }            
                end
            end
            
       else
       
            @keyword = Keyword.new(params[:keyword])
        
            
            respond_to do |format|
              if @keyword.save
                  
                  # msg = _post_data("aaaaa", @keyword)
                  # _get_backup_url => utils2.rb
                  t = Thread.new do
                      
                      msg = _post_data(Const::BACKUP_URL_NR4_KEYWORDS, @keyword)
                      # msg = _post_data(_get_backup_url, @keyword)
                      
                  end
                  
                format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
                format.json { render json: @keyword, status: :created, location: @keyword }
              else
                format.html { render action: "new" }
                format.json { render json: @keyword.errors, status: :unprocessable_entity }
              end
            end
       end#if tokens.length > 1
        
  end

  # PUT /keywords/1
  # PUT /keywords/1.json
  def update
    @keyword = Keyword.find(params[:id])
    
    

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to keywords_url }
      format.json { head :no_content }
    end
  end


    def show_genre_list
        
        # @genre = Genre.first
        @genres = Genre.all
        
        # layout 'layouts/nr4/keywords/show_genre_list'
        #REF http://www.rubylife.jp/rails/template/index3.html#section3
        render :layout => 'layouts/nr4/keywords/show_genre_list'
        
        #debug
        write_log(
                  @log_path,
                  "show_genre_list",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        # respond_to do |format|
          # format.html { redirect_to keywords_url }
          # format.json { head :no_content }
        # end
        
        # respond_to do |format|
          # format.html # index.html.erb
          # #format.json { render json: @keywords }
        # end        
        
    end#show_genre_list
    
    def show_category_list
        
        # @genre = Genre.first
        @genres = Genre.all
        
        @genre = params[:selected_genre]
        
        @categories = Category.find(:all, :conditions => {:genre_id => @genre})
        
        # @categories.sort!
        @categories.sort! do |c1, c2|
           
            c1.name <=> c2.name
            # c1.name <=> c2.name
            
        end
        
        # layout 'layouts/nr4/keywords/show_genre_list'
        #REF http://www.rubylife.jp/rails/template/index3.html#section3
        render :layout => 'layouts/nr4/keywords/show_genre_list'
        
        #debug
        write_log(
                  @log_path,
                  "show_category_list/selected_genre=#{@genre}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        # respond_to do |format|
          # format.html { redirect_to keywords_url }
          # format.json { head :no_content }
        # end
        
        # respond_to do |format|
          # format.html # index.html.erb
          # #format.json { render json: @keywords }
        # end        
        
    end#show_category_list
  
private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end
    
    def _index__1_sort(sort_key)
        
        if sort_key == "id"
            
            @keywords.sort! {|k1, k2|
                
                k1.id <=> k2.id
            }
            
        elsif sort_key == "category"
            
            #REF http://ref.xaio.jp/ruby/classes/array/sort
            @keywords.sort! {|k1, k2|
                
                k1.category.id <=> k2.category.id
            }
            
        elsif sort_key == "genre"
            
            @keywords.sort! {|k1, k2|
                
                k1.category.genre.id <=> k2.category.genre.id
            }
            
        elsif sort_key == "name"
            
            @keywords.sort! {|k1, k2|
                
                k1.name <=> k2.name
            }
            
        else
            
        end
        
    end#_index__1_sort(sort_key)
    
    def _index__2_filter(filter)
        
        settings = SettingsNr4.first
        
        #----------------------
        # Filter: Genre
        #----------------------
        
        
        
    end#_index__2_filter(params['filter'])

end
