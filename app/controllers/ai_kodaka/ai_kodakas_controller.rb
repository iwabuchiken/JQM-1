class AiKodaka::AiKodakasController < ApplicationController
  # GET /ai_kodakas
  # GET /ai_kodakas.json
  def index
    @ai_kodakas = AiKodaka.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ai_kodakas }
    end
  end

  # GET /ai_kodakas/1
  # GET /ai_kodakas/1.json
  def show
    @ai_kodaka = AiKodaka.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ai_kodaka }
    end
  end

  # GET /ai_kodakas/new
  # GET /ai_kodakas/new.json
  def new
    @ai_kodaka = AiKodaka.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ai_kodaka }
    end
  end

  # GET /ai_kodakas/1/edit
  def edit
    @ai_kodaka = AiKodaka.find(params[:id])
  end

  # POST /ai_kodakas
  # POST /ai_kodakas.json
  def create
    @ai_kodaka = AiKodaka.new(params[:ai_kodaka])

    respond_to do |format|
      if @ai_kodaka.save
        format.html { redirect_to @ai_kodaka, notice: 'Ai kodaka was successfully created.' }
        format.json { render json: @ai_kodaka, status: :created, location: @ai_kodaka }
      else
        format.html { render action: "new" }
        format.json { render json: @ai_kodaka.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ai_kodakas/1
  # PUT /ai_kodakas/1.json
  def update
    @ai_kodaka = AiKodaka.find(params[:id])

    respond_to do |format|
      if @ai_kodaka.update_attributes(params[:ai_kodaka])
        format.html { redirect_to @ai_kodaka, notice: 'Ai kodaka was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ai_kodaka.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ai_kodakas/1
  # DELETE /ai_kodakas/1.json
  def destroy
    @ai_kodaka = AiKodaka.find(params[:id])
    @ai_kodaka.destroy

    respond_to do |format|
      format.html { redirect_to ai_kodakas_url }
      format.json { head :no_content }
    end
  end
end
