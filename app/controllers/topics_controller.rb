class TopicsController < ApplicationController
  before_filter :require_login
  
  def index
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @title = "#{@subject.name} Topics"
    @topics = @subject.topics
  end

  def new
    @title = "New Topic"
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.new
  end

  def edit
    @title = "Edit Topic"
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.user_id = current_user.id
    respond_to do |format|
      if @topic.save
        format.html { redirect_to subject_topics_path(@topic.subject_id), notice: 'Topic was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to subject_topics_path(@topic.subject_id), notice: 'Topic was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to subject_topics_url }
      format.json { head :no_content }
    end
  end

  private
 
  def require_login
    unless user_signed_in?
      redirect_to root_url, flash: { error: "You must be logged in to access this section"}
    end
  end

  def set_title
    @title = "Subjects"
  end
end
