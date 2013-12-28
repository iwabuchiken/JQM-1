class Sl::SettingSlsController < ApplicationController
  
  layout 'layouts/sl/sl_main'
  
  # GET /setting_sls
  # GET /setting_sls.json
  def index
    @setting_sls = SettingSl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @setting_sls }
    end
  end

  # GET /setting_sls/1
  # GET /setting_sls/1.json
  def show
    @setting_sl = SettingSl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setting_sl }
    end
  end

  # GET /setting_sls/new
  # GET /setting_sls/new.json
  def new
    @setting_sl = SettingSl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @setting_sl }
    end
  end

  # GET /setting_sls/1/edit
  def edit
    @setting_sl = SettingSl.find(params[:id])
  end

  # POST /setting_sls
  # POST /setting_sls.json
  def create
    @setting_sl = SettingSl.new(params[:setting_sl])

    respond_to do |format|
      if @setting_sl.save
        format.html { redirect_to @setting_sl, notice: 'Setting sl was successfully created.' }
        format.json { render json: @setting_sl, status: :created, location: @setting_sl }
      else
        format.html { render action: "new" }
        format.json { render json: @setting_sl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /setting_sls/1
  # PUT /setting_sls/1.json
  def update
    @setting_sl = SettingSl.find(params[:id])

    respond_to do |format|
      if @setting_sl.update_attributes(params[:setting_sl])
        format.html { redirect_to @setting_sl, notice: 'Setting sl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting_sl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setting_sls/1
  # DELETE /setting_sls/1.json
  def destroy
    @setting_sl = SettingSl.find(params[:id])
    @setting_sl.destroy

    respond_to do |format|
      format.html { redirect_to setting_sls_url }
      format.json { head :no_content }
    end
  end
end
