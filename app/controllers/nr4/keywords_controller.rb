#encoding: utf-8

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

    @keywords = Keyword.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end

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
    
    @categories = Category.all
    
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
            
            #aa
            
            tokens.length.times do |i|
            
                keyword = Keyword.new(params[:keyword])
                
                keyword.name = tokens[i]
                
                
                
                if keyword.save
                
                    @keyword = keyword
                    
                end
                
            end
            
            respond_to do |format|
                if @keyword != nil
                    format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
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
  
private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end

end
