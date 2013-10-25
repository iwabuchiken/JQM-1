class KeyWordSetsController < ApplicationController
  # GET /key_word_sets
  # GET /key_word_sets.json
  def index
    @key_word_sets = KeyWordSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @key_word_sets }
    end
  end

  # GET /key_word_sets/1
  # GET /key_word_sets/1.json
  def show
    @key_word_set = KeyWordSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @key_word_set }
    end
  end

  # GET /key_word_sets/new
  # GET /key_word_sets/new.json
  def new
    @key_word_set = KeyWordSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @key_word_set }
    end
  end

  # GET /key_word_sets/1/edit
  def edit
    @key_word_set = KeyWordSet.find(params[:id])
  end

  # POST /key_word_sets
  # POST /key_word_sets.json
  def create
    @key_word_set = KeyWordSet.new(params[:key_word_set])

    respond_to do |format|
      if @key_word_set.save
        format.html { redirect_to @key_word_set, notice: 'Key word set was successfully created.' }
        format.json { render json: @key_word_set, status: :created, location: @key_word_set }
      else
        format.html { render action: "new" }
        format.json { render json: @key_word_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /key_word_sets/1
  # PUT /key_word_sets/1.json
  def update
    @key_word_set = KeyWordSet.find(params[:id])

    respond_to do |format|
      if @key_word_set.update_attributes(params[:key_word_set])
        format.html { redirect_to @key_word_set, notice: 'Key word set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @key_word_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /key_word_sets/1
  # DELETE /key_word_sets/1.json
  def destroy
    @key_word_set = KeyWordSet.find(params[:id])
    @key_word_set.destroy

    respond_to do |format|
      format.html { redirect_to key_word_sets_url }
      format.json { head :no_content }
    end
  end
end
