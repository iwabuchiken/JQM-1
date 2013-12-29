class Sl::ItemsController < ApplicationController
  
  layout 'layouts/sl/sl_main'
  
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    
    #debug
        #debug
    write_log(
              Const::SL::LOG_PATH_SL,
              "items_controller#index",
              # __FILE__,
              __FILE__.split("/")[-1],
              __LINE__.to_s)

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

    def show_log
        
        #REF File.join // http://d.hatena.ne.jp/lurker/20060618/1150604454
        #target = "doc/mylog/articles/log.log"
        target = File.join(Const::SL::LOG_PATH_SL, Const::SL::LOG_FILE_NAME)
        
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


end
