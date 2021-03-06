class Nr4::GenresController < ApplicationController
  # GET /genres
  # GET /genres.json
  
  require 'nlp'
  
  layout 'layouts/nr4/genres'

  #REF http://maskana-soft.com/rails/pro/body/41
  before_filter :log_path
  
  def index
    @genres = Genre.all

    # @message = NLP::MESSAGE
    # @message = NLP.new().show_message # => undefined method `new' for NLP:Module
    # @message = NLP::NLPCLASS.new  # => uninitialized constant NLP::NLPCLASS
    
    # => REF class variable // http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
    message = NLP.new()
    
    @history = History.last
    
    @message = NLP.get_message
    # @message = NLP.message
    # @message = message.get_message
    # @message = message.message
    # @message = message.MESSAGE
    # @message = "abcdef"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genres }
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/new
  # GET /genres/new.json
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render json: @genre, status: :created, location: @genre }
      else
        format.html { render action: "new" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /genres/1
  # PUT /genres/1.json
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to genres_url }
      format.json { head :no_content }
    end

  end

    def show_log
        
        target = "doc/mylog/articles/log.log"
        
        @content = ""
        
        if File.exists?(target)
          
          contentArray = File.readlines(target).reverse!
    
        else
          
          contentArray = ['No log data']
          
        end
        
        respond_to do |format|
          format.html { render :text => contentArray.join('<br/>') }
          # format.json { head :no_content }
        end        
    end#show_log

private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end


end
