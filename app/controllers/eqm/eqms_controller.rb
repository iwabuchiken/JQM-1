class Eqm::EqmsController < ApplicationController
    
    layout 'layouts/eqm/eqm_main'
    
  # GET /eqms
  # GET /eqms.json
  def index
    @eqms = Eqm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eqms }
    end
  end

  # GET /eqms/1
  # GET /eqms/1.json
  def show
    @eqm = Eqm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eqm }
    end
  end

  # GET /eqms/new
  # GET /eqms/new.json
  def new
    @eqm = Eqm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eqm }
    end
  end

  # GET /eqms/1/edit
  def edit
    @eqm = Eqm.find(params[:id])
  end

  # POST /eqms
  # POST /eqms.json
  def create
    @eqm = Eqm.new(params[:eqm])

    respond_to do |format|
      if @eqm.save
        format.html { redirect_to @eqm, notice: 'Eqm was successfully created.' }
        format.json { render json: @eqm, status: :created, location: @eqm }
      else
        format.html { render action: "new" }
        format.json { render json: @eqm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eqms/1
  # PUT /eqms/1.json
  def update
    @eqm = Eqm.find(params[:id])

    respond_to do |format|
      if @eqm.update_attributes(params[:eqm])
        format.html { redirect_to @eqm, notice: 'Eqm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eqm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eqms/1
  # DELETE /eqms/1.json
  def destroy
    @eqm = Eqm.find(params[:id])
    @eqm.destroy

    respond_to do |format|
      format.html { redirect_to eqms_url }
      format.json { head :no_content }
    end
  end
end
