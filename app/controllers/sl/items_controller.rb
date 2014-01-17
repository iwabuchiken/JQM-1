class Sl::ItemsController < ApplicationController
  
  layout 'layouts/sl/sl_main'
  
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.find(:all, :order => 'id ASC')
    # @items = Item.all
    
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
          
          #debug
          write_log(
                Const::SL::LOG_PATH_SL,
                "res => true",
                # __FILE__,
                __FILE__.split("/")[-1],
                __LINE__.to_s)
          
          redirect_to :controller => 'items', :action => 'index'
          
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

    def delete_all
        #REF delete_all http://stackoverflow.com/questions/5322298/deleting-all-records-in-a-database answered Mar 16 '11 at 7:47
        res = Item.delete_all
        
        #debug
        write_log(
                  Const::SL::LOG_PATH_SL,
                  "#{Rails.application.class.to_s.split("::").first} \
                        #{params[:controller]} # #{__method__} // res => #{res}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
        
        
        redirect_to items_path, notice: 'Items were all deleted.'
        
    end#delete_all

private
  #=================================
  # => _new_data_from_device
  # => @return false => param "passwd_XX" --> nill
  # =>          true => Operation done
  #=================================
  def _new_data_from_device
        
        if !params[Const::SL::PASSWD_SL_Key]
            
            #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  "!params['passwd_sl'](params => #{params.keys}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
            
            return false
            
        else#if !params['passwd_sl']
            
              #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  "params['passwd_sl'] => " + params['passwd_sl'].to_s,
                  #"params['passwd'] => " + params['passwd'].to_s,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
=begin            
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
=end
            msg = ""
            
            if params[Const::SL::PASSWD_SL_Key] \
                        == Const::SL::PASSWD_SL_NewItem
                
                msg = _new_data_from_device_NewItem
    
            elsif params[Const::SL::PASSWD_SL_Key] \
                        == Const::SL::PASSWD_SL_PurHist#if params['passwd_sl'] == Const::SL::PASSWD_SL_NEW
                
                msg = _new_data_from_device_PurHist
                
            end#if params['passwd_sl'] == Const::SL::PASSWD_SL_NEW
            
              #debug
            write_log(
                  Const::SL::LOG_PATH_SL,
                  msg,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
            return true
            
        end#if !params['passwd_sl']
        
  end#def _new__1_data_from_device

    def _new_data_from_device_PurHist
        
        hist = PurHist.new()
        #item = Item.new
        
        hist.item_ids   = params['sl_BoughtItemIds']
        
        hist.pur_date   = params['sl_PurHistory_Time']
        
        #debug
        write_log(
                  Const::SL::LOG_PATH_SL,
                  "hist => #{hist}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)        
        
        if hist.save
            
            msg = "New PurHist saved => #{item.class.to_s}"
            
        else
            
            msg = "Saving new PurHist => Failed"
            
        end

        write_log(
                  Const::SL::LOG_PATH_SL,
                  msg,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

        return msg
        
    end#def _new_data_from_device_PurHist
    
    def _new_data_from_device_NewItem

        item = Item.new()
        #item = Item.new
        
        item.mobile_id  = params['item_mobile_id']
        
        item.name       = params['item_name']
        item.store_id   = params['item_store_id']
        
        item.price      = params['item_price']
        item.genre_id   = params['item_genre_id']
        
        item.yomi       = params['item_yomi']
        
        item.mobile_created_at  = params['item_mobile_created_at']
        item.mobile_updated_at  = params['item_mobile_updated_at']
        item.mobile_posted_at   = params['item_mobile_posted_at']
        
        if item.save
            
            msg = "New item saved => #{item.class.to_s}"
            
        else
            
            msg = "Saving new item => Failed"
            
        end

        return msg
        
    end#def _new_data_from_device_NewItem

end
