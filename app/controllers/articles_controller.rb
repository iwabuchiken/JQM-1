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

    #----------------------
    # Get: Genres list
    #----------------------
    @genres = get_genres_list()

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
    
    @content = get_tag_content(@articles_set[0])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
    
  end#def index

    def get_num_of_docs()
    
        return 3
        
    end#def get_num_of_docs()
    
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
        
        #=====================
        # 3. Get a_tags
        #=====================
        a_tags = get_atags(docs)

        #=====================
        # 3. Get a_tags
        #=====================
        articles_set = build_articles_set(a_tags)

        #=====================
        # Get: Categorized articles set
        #=====================
        categorized_set = build_categorized_set(articles_set, genre)




        return categorized_set
                
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

      def get_atags(docs)
      
          a_tags_href = []
          
          vendor_list = []
      
          docs.each do |doc|
                #--------------------
                # Modify 'a' tags
                #--------------------
                
                # Get 'a' tags
                a_tags = doc.css("div ul li a")
                
                # href value
                a_tags.each do |a_tag|
                  if a_tag['href'].start_with?("/hl?")
                    # Modify url
                    a_tag['href'] = "http://headlines.yahoo.co.jp" + a_tag['href']
                    
                    # Add
                    a_tags_href.push(a_tag)
                    
                  end#if a_tag['href'].start_with?("/hl?")
                end#a_tags.each do |a_tag|
  
        
          end#docs.each do |doc|
  
          #debug
          write_log(
                  @log_path,
                  "vendor_list.size=" + vendor_list.size.to_s +
                  "/" + "a_tags_href.size=" + a_tags_href.size.to_s,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
  
  
          # Return
          return a_tags_href
    
    end#def get_atags

    def get_tag_content(a_tag)
        
        #REF http://nokogiri.org/Nokogiri/XML/Node.html ** https://blog.engineyard.com/2010/getting-started-with-nokogiri
        return a_tag.content
    
#        doc = Nokogiri::HTML(a_tag)
#        
#        return doc.xpath('a').first.text
    
    
    end#def get_tag_content(a_tag)

    def build_articles_set(a_tags)
        
        return a_tags
        
    end#def build_articles_set(a_tags)

    def build_categorized_set(articles_set, genre="soci")
        
        #==============================
        # Get: Categories for the genre
        # Get: Keywords for each obtained category
        # Build: List of categorized articles
        #==============================
        
        # Array
        categories = get_categories(genre)
        
        # Hash
        keywords = get_keywords(genre, categories)
        
        
        
        categorized_set = articles_set
        
        return categorized_set
        # aa
    end#build_categorized_set(articles_set)

    def get_categories(genre)
        
        if genre == 'int'
            
            return _get_categories_int()
            # return ['China', 'Others']
            
        else
            
            return ['Others']
            
        end
        
        
    end#get_categories(genre)

    def _get_categories_int()
      
        return ['China', 'Others']
      
    end

    def get_keywords(genre, categories)
        
        if genre == 'int'
            
            return {
                "China" =>  ["中国", "尖閣"],
                "US" =>     ["米国", "オバマ"] }
            
        else
            
            return []
            
        end
        
        
    end#get_keywords(genre, categories)

    def get_genre()
        
        if params['genre']
        
            p_genre = params['genre']
  
        else
          
            p_genre = session[:genre]
          
        end
    
        if p_genre != nil
          
            write_log(
                    @log_path,
                    "genre => #{p_genre}",
                    __FILE__, __LINE__)
                    
            return p_genre
          
        else
      
            write_log(
                    @log_path,
                    "genre => soci",
                    __FILE__, __LINE__)
          
            return "soci"
      
        end
        
    end#    def get_genre()

    def get_genres_list()
        
        genres_src = Genre.all
        
        genres = {}
        
        genres_src.each do |item|
           genres[item.name] = item.code
        end
        
        return genres
        
    end#get_genres_list()
    
end#class ArticlesController < ApplicationController
