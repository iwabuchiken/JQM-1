class VisualsController < ApplicationController
  # GET /visuals
  # GET /visuals.json
  def index
    @visuals = Visual.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visuals }
    end
  end

  # GET /visuals/1
  # GET /visuals/1.json
  def show
    @visual = Visual.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visual }
    end
  end

  # GET /visuals/new
  # GET /visuals/new.json
  def new
    @visual = Visual.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visual }
    end
  end

  # GET /visuals/1/edit
  def edit
    @visual = Visual.find(params[:id])
  end

  # POST /visuals
  # POST /visuals.json
  def create
    @visual = Visual.new(params[:visual])

    respond_to do |format|
      if @visual.save
        format.html { redirect_to @visual, notice: 'Visual was successfully created.' }
        format.json { render json: @visual, status: :created, location: @visual }
      else
        format.html { render action: "new" }
        format.json { render json: @visual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /visuals/1
  # PUT /visuals/1.json
  def update
    @visual = Visual.find(params[:id])

    respond_to do |format|
      if @visual.update_attributes(params[:visual])
        format.html { redirect_to @visual, notice: 'Visual was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visuals/1
  # DELETE /visuals/1.json
  def destroy
    @visual = Visual.find(params[:id])
    @visual.destroy

    respond_to do |format|
      format.html { redirect_to visuals_url }
      format.json { head :no_content }
    end
  end
end
