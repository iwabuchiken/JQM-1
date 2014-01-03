class Sl::ItemsController < ApplicationController
  
  layout 'layouts/sl/sl_main'
  
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    
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
    
    res = _new_data_from_device
    
    if res == true
          
          # redirect_to :controller => 'items', :action => 'index'
          
          return
        
    end

    
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
    
    #debug
    write_log(
              Const::SL::LOG_PATH_SL,
              "items_controller#create(params[:item] => #{params[:item]})",
              # __FILE__,
              __FILE__.split("/")[-1],
              __LINE__.to_s)

    
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

private
  def _new_data_from_device
        
        if !params['passwd']
        # if !params['passwd_sl']
            
            #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  "!params['passwd_sl']",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
            
            
        # if !params['password_sl']
            
            return false
            
        else
            
              #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  "params['passwd'] => " + params['passwd'].to_s,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
            
            #REF app name // http://stackoverflow.com/questions/3539148/how-do-i-access-the-name-of-the-rails-3-application-object Rails.application.class.to_s.split("::").first
            #REF method name // http://stackoverflow.com/questions/6426598/how-to-get-current-method-in-rails-3 answered Jun 21 '11 at 15:53
            #REF cont name // http://stackoverflow.com/questions/3757491/can-i-get-the-name-of-the-current-controller-in-the-view answered Sep 21 '10 at 5:27
              #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  "#{Rails.application.class.to_s.split("::").first} 
                        #{params[:controller]} # #{__method__}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
    
            if params['item']
            
                # msg = "#{params['item']}(#{params['item']['name']})"
                # msg = params['item']
                
                item = Item.new
                
                item.name = params['item']['name']
                
                if item.save
                    
                    msg = "New item saved => #{params['item']}"
                    
                else
                    
                    msg = "Saving new item => Failed"
                    
                end
                
              
            else
          
                msg = "params['item'] => null"
                
                #debug
                write_log(
                      Const::SL::LOG_PATH_SL,
                      msg,
                      # __FILE__,
                      __FILE__.split("/")[-1],
                      __LINE__.to_s)
                
                return false
    
            end#if params['item']
    
              #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  msg,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
            respond_to do |format|
                
                format.json {render json: item}
                
            end
            # render :text => msg
            # render :text => "DONE"
            
            return true
            
        end#if !params['password_sl']
        
  end#def _new__1_data_from_device


end
