class SubjectsController < ApplicationController
  before_filter :require_login

  def index
    @title = "Subjects"
    @user = User.find(current_user.id)
    @subjects = @user.subjects.all

    respond_to do |format|
      format.html
      format.json { render json: @subjects }
    end
  end

  def new
    @title = "New Subject"
    @subject = Subject.new

    respond_to do |format|
      format.html
      format.json { render json: @subject }
    end
  end

  def edit
    @title = "Edit Subject"
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:id])
  end

  def create
    @subject = Subject.new(params[:subject])
    @subject.user_id = current_user.id
    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_url, notice: 'Subject was successfully created.' }
        format.json { render json: @subject, status: :created, location: @subject }
      else
        format.html { render action: "new" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @subject = Subject.find(params[:id])

    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to subjects_url, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:id])
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :no_content }
    end
  end

  private
 
  def require_login
    unless user_signed_in?
      redirect_to root_url, flash: { error: "You must be logged in to access this section"}
    end
  end
end
