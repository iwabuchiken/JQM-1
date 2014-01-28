#encoding: utf-8
# require 'moji'

class Natulang::NatulangsController < ApplicationController
    
    layout 'layouts/natulang/natulang_main'
    
  # GET /natulangs
  # GET /natulangs.json
  def index
    @natulangs = Natulang.all

    @text = History.last.content

    @msg = Moji.type("漢")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @natulangs }
    end
  end

  # GET /natulangs/1
  # GET /natulangs/1.json
  def show
    @natulang = Natulang.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @natulang }
    end
  end

  # GET /natulangs/new
  # GET /natulangs/new.json
  def new
    @natulang = Natulang.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @natulang }
    end
  end

  # GET /natulangs/1/edit
  def edit
    @natulang = Natulang.find(params[:id])
  end

  # POST /natulangs
  # POST /natulangs.json
  def create
    @natulang = Natulang.new(params[:natulang])

    respond_to do |format|
      if @natulang.save
        format.html { redirect_to @natulang, notice: 'Natulang was successfully created.' }
        format.json { render json: @natulang, status: :created, location: @natulang }
      else
        format.html { render action: "new" }
        format.json { render json: @natulang.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /natulangs/1
  # PUT /natulangs/1.json
  def update
    @natulang = Natulang.find(params[:id])

    respond_to do |format|
      if @natulang.update_attributes(params[:natulang])
        format.html { redirect_to @natulang, notice: 'Natulang was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @natulang.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /natulangs/1
  # DELETE /natulangs/1.json
  def destroy
    @natulang = Natulang.find(params[:id])
    @natulang.destroy

    respond_to do |format|
      format.html { redirect_to natulangs_url }
      format.json { head :no_content }
    end
  end
end
