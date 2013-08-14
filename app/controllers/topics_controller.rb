class TopicsController < ApplicationController
  
  def index
    @subject = Subject.find(params[:subject_id])
    @topics = @subject.topics
  end
  
  def show
    @subject = Subject.find(params[:subject_id])
    @topic = @subject.topics.find(params[:id])
  end

  def new
    @subject = Subject.find(params[:subject_id])
    @topic = @subject.topics.new
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])
    respond_to do |format|
      if @topic.save
        format.html { redirect_to subject_topic_path(@topic.subject_id, @topic.id), notice: 'Topic was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to subject_topic_path(@topic.subject_id, @topic.id), notice: 'Topic was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to subject_topics_url }
      format.json { head :no_content }
    end
  end
end
