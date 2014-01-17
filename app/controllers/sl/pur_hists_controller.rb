class Sl::PurHistsController < ApplicationController
  
  # layout 'layouts/sl/sl_pur_hist'
  layout 'layouts/sl/sl_main'
  
  # GET /pur_hists
  # GET /pur_hists.json
  def index
    @pur_hists = PurHist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pur_hists }
    end
  end

  # GET /pur_hists/1
  # GET /pur_hists/1.json
  def show
    @pur_hist = PurHist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pur_hist }
    end
  end

  # GET /pur_hists/new
  # GET /pur_hists/new.json
  def new
    @pur_hist = PurHist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pur_hist }
    end
  end

  # GET /pur_hists/1/edit
  def edit
    @pur_hist = PurHist.find(params[:id])
  end

  # POST /pur_hists
  # POST /pur_hists.json
  def create
    @pur_hist = PurHist.new(params[:pur_hist])

    respond_to do |format|
      if @pur_hist.save
        format.html { redirect_to @pur_hist, notice: 'Pur hist was successfully created.' }
        format.json { render json: @pur_hist, status: :created, location: @pur_hist }
      else
        format.html { render action: "new" }
        format.json { render json: @pur_hist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pur_hists/1
  # PUT /pur_hists/1.json
  def update
    @pur_hist = PurHist.find(params[:id])

    respond_to do |format|
      if @pur_hist.update_attributes(params[:pur_hist])
        format.html { redirect_to @pur_hist, notice: 'Pur hist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pur_hist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pur_hists/1
  # DELETE /pur_hists/1.json
  def destroy
    @pur_hist = PurHist.find(params[:id])
    @pur_hist.destroy

    respond_to do |format|
      format.html { redirect_to pur_hists_url }
      format.json { head :no_content }
    end
  end
end
