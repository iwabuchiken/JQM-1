class Nr4::HistoriesController < ApplicationController

  layout 'layouts/nr4/genres'

  #REF http://maskana-soft.com/rails/pro/body/41
  before_filter :log_path

  # GET /histories
  # GET /histories.json
  def index
      
      per_page = _index_get_per_page()
    @histories = History.paginate(
                          :page => params[:page],
                          :order => 'created_at asc',
                          :per_page => per_page)
                          # :per_page => per_page,
                          # :conditions => ['memos LIKE ?', "%#{search_word}%"])

    @history_size = History.all.size
    
        #debug
        write_log(
                  @log_path,
                  "@histories.size => " + @histories.size.to_s,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @histories }
    end
  end

    def _index_get_per_page
        
        return 10
        
    end#_index_get_per_page
    
  # GET /histories/1
  # GET /histories/1.json
  def show
    @history = History.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/new
  # GET /histories/new.json
  def new
    @history = History.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/1/edit
  def edit
    @history = History.find(params[:id])
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render json: @history, status: :created, location: @history }
      else
        format.html { render action: "new" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /histories/1
  # PUT /histories/1.json
  def update
    @history = History.find(params[:id])

    respond_to do |format|
      if @history.update_attributes(params[:history])
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history = History.find(params[:id])
    @history.destroy

    respond_to do |format|
      format.html { redirect_to histories_url }
      format.json { head :no_content }
    end
  end
  
private

    def log_path
       
       @log_path = "doc/mylog/articles"
        
    end
  

end
