##coding:utf-8

require 'nokogiri'
require 'open-uri'

require 'utils'

class ArticlesController < ApplicationController
    
    # layout 'nr4/application'
    layout 'layouts/nr4/application'
    # layout 'nr4'
    # @@log_path = "doc/mylog/articles"
    
  # GET /articles
  # GET /articles.json
  def index
      
    #------------------------------
    # Set: Log path
    #------------------------------
    log_path
    
    # @articles = Article.all
    
    #------------------------------
    # 1. Get number of docs
    #------------------------------
    number = get_num_of_docs()
    
    #----------------------
    # 2. Set genre
    #----------------------
    @genre = get_genre()

    #debug
    write_log(
              @log_path,
              "genre=" + @genre,  
              # __FILE__,
              __FILE__.split("/")[-1],
              __LINE__.to_s)


    #----------------------
    # Get: Articles list
    #----------------------
    @articles_set = get_articles_set(number, @genre)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
    
  end#def index

    def get_num_of_docs()
    
        return 3
        
    end#def get_num_of_docs()
    
    def get_genre()
        
        return 'soci'
        
    end#    def get_genre()

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
  
private
    
    #REF http://stackoverflow.com/questions/9330486/same-instance-variable-for-all-actions-of-a-controller answered Feb 17 '12 at 15:09
    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end

    def get_articles_set(doc_num=3, genre="soci")
        
        #=====================
        # 2. Get docs
        #=====================
        docs = get_docs(doc_num, genre)
        
        
    end#def get_articles_set(doc_num=3, genre="soci")


    def get_docs(number, genre="soci")
        
        # Urls
        url = "http://headlines.yahoo.co.jp/hl?c=#{genre}&t=l&p="
    
        # HTML docs
        docs = []
        
        # Thread array
        threads = []

        # Get docs
        # 2.times do |i|
        number.times do |i|
        
            # Get docs
            threads << Thread.start(i, url) do
                # puts "Thred #{i.to_s}: " + urls[i] 
                # docs[i] = Nokogiri::HTML(open(urls[i]))
                docs[i] = Nokogiri::HTML(open(url + (i + 1).to_s))
            end
            
            # Join
            threads.each do |t|
                t.join
            end
            
        end#    number.times do |i|
    
        # Return
        return docs

    end#def get_docs(number)

end#class ArticlesController < ApplicationController
