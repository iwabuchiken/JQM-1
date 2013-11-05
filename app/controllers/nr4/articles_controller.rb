##coding:utf-8

require 'nokogiri'
require 'open-uri'

#require 'utils'
require 'utils2'

class Nr4::ArticlesController < ApplicationController
    
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

    articles_set = get_articles_set(number, @genre)

    #----------------------
    # Get: Articles models list
    #----------------------    
    #@articles_set = get_articles_model_set(articles_set)
    articles_model_set = get_articles_model_set(articles_set)
    
    
    @categorized_articles_set = get_categorized_set(articles_model_set, @genre)
    
    # @categorized_set = 
    
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
        articles_set = a_tags
        # articles_set = build_articles_set(a_tags)

        # #=====================
        # # Get: Categorized articles set
        # #=====================
        # if genre == 'int'
#           
            # categorized_set = build_categorized_set(articles_set, genre)
#             
        # else
#         
            # categorized_set = articles_set
#         
        # end

        return articles_set
        # return categorized_set
                
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

    def build_categorized_set(articles_set, genre="soci")
        
        #==============================
        # Get: Categories for the genre
        # Get: Keywords for each obtained category
        # Build: List of categorized articles
        #==============================
        
        # Array
        categories = get_categories(genre)
        
        # Array of KeyWordSet models
        keywords = get_keywords(genre, categories)
        
        
        
        categorized_set = articles_set
        
        return categorized_set
        
    end#build_categorized_set(articles_set)

    def get_categories(genre)
        
        if genre == 'int'
            
#            return _get_categories_int()
            return ['China', 'US']
            
        else
            
            return ['Others']
            
        end
        
        
    end#get_categories(genre)

    def get_keywords(genre)
        
        if genre == 'int'
            
            key_words_set = []
            
            kws1 = KeyWordSet.new
            
            kws1.category = "China"
            kws1.keywords = "中国 尖閣"

            kws2 = KeyWordSet.new
            kws2.category = "US"
            kws2.keywords = "米国 オバマ"
            
            key_words_set.push(kws1)
            key_words_set.push(kws2)
            
            return key_words_set
            
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


    def get_articles_model_set(articles_set)
        
        model_set = []
        
        articles_set.length.times {|i|
            
            a = Article.new
            
            a.line      = articles_set[i].content
            a.url       = articles_set[i]['href']
            a.vendor    = articles_set[i]['href'].split("=")[1].split("-")[2]
            a.news_time = articles_set[i]['href'].split("=")[1].split("-")[0]
            
            model_set.push(a)
            
        }
        
        return model_set
        
    end#get_articles_model_set(articles_set)
    
    def get_categorized_set(articles_model_set, genre)
    
        # Array
        if genre == 'int'
        
          return _get_categorized_set_int(articles_model_set, genre)
          
        else 
          
          return {
              'First'\
                    => articles_model_set[
                          0.. \
                          articles_model_set.length/2 - 1],
               'Others'\
                    => articles_model_set[
                          articles_model_set.length/2 \
                          ..articles_model_set.length - 1]}
          
        end
    
    end#get_categorized_set(articles_model_set, @genre)
    
    def _get_categorized_set_int__v_1_55(articles_model_set, genre)
        
        key_word_sets = _get_keywords_set_int()
        #key_word_set = ['China', 'US', 'Others']
        
        category_names = []
        
        categorized_sets = {}
        
        # China
        
        kws1 = key_word_sets[0]
        keywords = kws1.keywords.split(' ')
        
        #category_name = kws1.category
        category_names.push(kws1.category)
        
        new_set = []
        
        articles_model_set.size.times do |i|
        
            keywords.size.times do |j|
            
                if articles_model_set[i].line.include?(keywords[j])
                    
                    new_set.push(articles_model_set[i])
                    
                    break
                    
                end
            
            end#keywords.size.times do |kw,j|
        
        
        end#articles_model_set.size.times do |a,i|
        
        residue_set = articles_model_set - new_set
        
        categorized_sets[category_names[0]] = new_set
        
        # US
        
        kws2 = key_word_sets[1]
        keywords = kws2.keywords.split(' ')
        
        category_names.push(kws2.category)
        #category_name = kws2.category
        
        new_set = []
        
        residue_set.size.times do |i|
        
            keywords.size.times do |j|
            
                if residue_set[i].line.include?(keywords[j])
                    
                    new_set.push(residue_set[i])
                    
                    break
                    
                end
            
            end#keywords.size.times do |kw,j|
        
        
        end#articles_model_set.size.times do |a,i|
        
        residue_set = residue_set - new_set
        # residue_set = articles_model_set - new_set
        
        categorized_sets[category_names[1]] = new_set
        
        # Others
        category_names.push("Others")
        
        categorized_sets[category_names[2]] = residue_set
        
        #debug
        write_log(
                  @log_path,
                  "new_set.size=#{new_set.size}"\
                  + "/residue_set.size=#{residue_set.size}"\
                  + "/articles_model_set.size=#{articles_model_set.size}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
        
        # Build the return value
        result = {}
        
        category_names.each_with_index do |c, i|
            
            result[category_names[i]] = categorized_sets[category_names[i]]
          
        end
        
        #debug
        write_log(
                  @log_path,
                  "result.size => #{result.size}"\
                  + "/result.keys => #{result.keys}",  
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        
        return result
        
        # return {
             # category_names[0] \
                  # => categorized_sets[category_names[0]],
#              
             # category_names[1] \
                  # => categorized_sets[category_names[1]],
# 
# #             'US'\
# #                  => residue_set[
# #                        00 \
# #                        ..(residue_set.length * 1/2)],
# 
             # category_names[-1] \
                  # => categorized_sets[category_names[-1]]}
             # # category_names[2] \
                  # # => categorized_sets[category_names[2]]}
#                         
# #             'Others'\
# #                  => residue_set[
# #                        residue_set.length * 1/2 \
# #                        ..(residue_set.length - 1)]}
    
    end#_get_categorized_set_int(articles_model_set, genre)

    def _get_categorized_set_int(articles_model_set, genre)
        
        key_word_sets = _get_keywords_set_int()
        #key_word_set = ['China', 'US', 'Others']
        
        residue_set = articles_model_set
        
        categorized_set = {}
        
        # Start: Build list
        # key_word_sets.each_with_index do |i|
        key_word_sets.each_with_index do |item, i|
        
            kws = key_word_sets[i]
            
            keywords = kws.keywords.split(' ')
            
            new_set = []
            
            residue_set.size.times do |j|

                keywords.size.times do |h|
                
                    if residue_set[j].line.include?(keywords[h])
                        
                        new_set.push(residue_set[j])
                        
                        break
                        
                    end
                
                end#keywords.size.times do |h|
                
                
                
            end#residue_set.size.times do |j|
            
            residue_set = residue_set - new_set
            # sidue_set = residue_set - new_set
            
            # categorized_set[kws.category] = new_set
            #categorized_set[kws.category] = new_set.sort!{|x1, x2| x1.news_time <=> x2.news_time}
            categorized_set[kws.category] = 
                    new_set.sort!{|x1, x2| x2.news_time <=> x1.news_time}
            
          
        end#key_word_sets.each_with_index do |i|
        
        categorized_set['Others'] = residue_set
        
        return categorized_set
    
    end#_get_categorized_set_int(articles_model_set, genre)
    
    #==================================
    #   _get_keywords_set_int()
    # Return    => Array of KeyWordSet models
    #
    #==================================
    def _get_keywords_set_int_v_1_55()
    
        result = []
        
        genre_int = Genre.find(:all, :conditions => {:code => 'int'})[0]
        
        categories = Category.find(:all, :conditions => {:genre_id => genre_int.id})
        
        #debug
        if categories != nil
            
            write_log(
                      @log_path,
                      "categories.size => #{categories.size}",  
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)

        else
            write_log(
                      @log_path,
                      "categories => nil",  
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)            
        end
        
        if categories != nil and categories.size > 0
            
            kws1 = KeyWordSet.new
            kws1.category = 'China'
            kws1.keywords = '中国 日中'
            
            kws2 = KeyWordSet.new
            kws2.category = 'Europe'
    #        kws2.keywords = '米国 アメリカ'
            kws2.keywords = '欧州 イギリス ドイツ  フランス ロシア'
            
            result.push(kws1)
            result.push(kws2)
            
        else
            
            kws1 = KeyWordSet.new
            kws1.category = 'China'
            kws1.keywords = '中国 日中'
            
            kws2 = KeyWordSet.new
            kws2.category = 'US'
    #        kws2.keywords = '米国 アメリカ'
            kws2.keywords = '米国 アメリカ オバマ 米選挙'
            
            result.push(kws1)
            result.push(kws2)
            
        end
        
        
        return result
    
    end#_get_keywords_set_int_v_1_55()
    
    def _get_keywords_set_int()
    
        result = []
        
        genre_int = Genre.find(:all, :conditions => {:code => 'int'})[0]
        
        categories = Category.find(:all, :conditions => {:genre_id => genre_int.id})
        
        #debug
        if categories != nil
            
            write_log(
                      @log_path,
                      "categories.size => #{categories.size}",  
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)

        else
            write_log(
                      @log_path,
                      "categories => nil",  
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)            
        end
        
        if categories != nil and categories.size > 0
            
            kws1 = KeyWordSet.new
            kws1.category = 'China'
            
            #REF http://railsdoc.com/references/find
            keywords1 = Keyword.find(
                            :all,
                            :conditions \
                                => ["genre_id = ? and category_id = ?", 2, 1])
            
            if keywords1 == nil or keywords1.size < 1
              
                kws1.keywords = '中国 日中 天安門'
                
            else
              
                #kws1.keywords = keywords1.collect{|kw| kw.name}
                kws1.keywords = keywords1.collect{|kw| kw.name}.join(" ")
              
            end
            
            
            kws2 = KeyWordSet.new
            kws2.category = 'Europe'
    #        kws2.keywords = '米国 アメリカ'
            kws2.keywords = '欧州 イギリス ドイツ  フランス ロシア'
            
            kws3 = KeyWordSet.new
            kws3.category = 'US'
    # #        kws3.keywords = '米国 アメリカ'
            kws3.keywords = '米国 オバマ アメリカ 米軍 米政府 米ＮＳＡ 米NSA 米上院 米大統領'
#           
            result.push(kws1)
            result.push(kws2)
            result.push(kws3)
            
        else
            
            kws1 = KeyWordSet.new
            kws1.category = 'China'
            kws1.keywords = '中国 日中'
            
            kws2 = KeyWordSet.new
            kws2.category = 'US'
    #        kws2.keywords = '米国 アメリカ'
            kws2.keywords = '米国 アメリカ オバマ 米選挙'
            
            result.push(kws1)
            result.push(kws2)
            
        end
        
        
        return result
    
    end#_get_keywords_set_int()
    
    
end#class ArticlesController < ApplicationController
