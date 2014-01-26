class NlpsController < ApplicationController
  # GET /nlps
  # GET /nlps.json
  def index
    @nlps = Nlp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nlps }
    end
  end

  # GET /nlps/1
  # GET /nlps/1.json
  def show
    @nlp = Nlp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nlp }
    end
  end

  # GET /nlps/new
  # GET /nlps/new.json
  def new
    @nlp = Nlp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nlp }
    end
  end

  # GET /nlps/1/edit
  def edit
    @nlp = Nlp.find(params[:id])
  end

  # POST /nlps
  # POST /nlps.json
  def create
    @nlp = Nlp.new(params[:nlp])

    respond_to do |format|
      if @nlp.save
        format.html { redirect_to @nlp, notice: 'Nlp was successfully created.' }
        format.json { render json: @nlp, status: :created, location: @nlp }
      else
        format.html { render action: "new" }
        format.json { render json: @nlp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nlps/1
  # PUT /nlps/1.json
  def update
    @nlp = Nlp.find(params[:id])

    respond_to do |format|
      if @nlp.update_attributes(params[:nlp])
        format.html { redirect_to @nlp, notice: 'Nlp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nlp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nlps/1
  # DELETE /nlps/1.json
  def destroy
    @nlp = Nlp.find(params[:id])
    @nlp.destroy

    respond_to do |format|
      format.html { redirect_to nlps_url }
      format.json { head :no_content }
    end
  end
end
