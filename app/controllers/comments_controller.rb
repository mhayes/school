class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :destroy, :update]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    @comment.user_id = current_user.id


    respond_to do |format|
      format.js # new.html.erb
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.rating = 0
    current_user.log(params[:action], @comment)

    if params[:result].present?
      @r = "result"
      puts "%%%"
      puts "%%%"
      puts "%%%"
    end

    puts "###"
    puts "###"
    puts "###"
    puts @comment.commentable.class.to_s
    puts "###"
    puts "###"
    puts "###"

    respond_to do |format|
      if @comment.save
        format.js # new.html.erb
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    current_user.log(params[:action], @comment)

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.js # new.html.erb
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user = @comment.user
    current_user.log(params[:action], @comment)


    respond_to do |format|
      format.js {render "create.js"}
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
