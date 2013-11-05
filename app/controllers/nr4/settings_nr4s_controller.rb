#class SettingsNr4sController < ApplicationController
class Nr4::SettingsNr4sController < ApplicationController
  # GET /settings_nr4s
  # GET /settings_nr4s.json
  
    #layout '../layouts/nr4/genres'
    layout 'layouts/nr4/genres'
    
  def index
    @settings_nr4s = SettingsNr4.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settings_nr4s }
    end
  end

  # GET /settings_nr4s/1
  # GET /settings_nr4s/1.json
  def show
    @settings_nr4 = SettingsNr4.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @settings_nr4 }
    end
  end

  # GET /settings_nr4s/new
  # GET /settings_nr4s/new.json
  def new
    @settings_nr4 = SettingsNr4.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @settings_nr4 }
    end
  end

  # GET /settings_nr4s/1/edit
  def edit
    @settings_nr4 = SettingsNr4.find(params[:id])
  end

  # POST /settings_nr4s
  # POST /settings_nr4s.json
  def create
    @settings_nr4 = SettingsNr4.new(params[:settings_nr4])

    respond_to do |format|
      if @settings_nr4.save
        format.html { redirect_to @settings_nr4, notice: 'Settings nr4 was successfully created.' }
        format.json { render json: @settings_nr4, status: :created, location: @settings_nr4 }
      else
        format.html { render action: "new" }
        format.json { render json: @settings_nr4.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settings_nr4s/1
  # PUT /settings_nr4s/1.json
  def update
    @settings_nr4 = SettingsNr4.find(params[:id])

    respond_to do |format|
      if @settings_nr4.update_attributes(params[:settings_nr4])
        format.html { redirect_to @settings_nr4, notice: 'Settings nr4 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @settings_nr4.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings_nr4s/1
  # DELETE /settings_nr4s/1.json
  def destroy
    @settings_nr4 = SettingsNr4.find(params[:id])
    @settings_nr4.destroy

    respond_to do |format|
      format.html { redirect_to settings_nr4s_url }
      format.json { head :no_content }
    end
  end
end
