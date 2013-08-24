class NotesController < ApplicationController
  before_filter :require_login

  # GET /notes
  # GET /notes.json
  def index
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @notes = @topic.notes
    @title = "#{@subject.name} - #{@topic.name} Notes"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @title = "New Note"
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @title = "Edit Note"
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @note = @topic.notes.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @note = Note.new(params[:note])
    @note.user_id = current_user.id

    respond_to do |format|
      if @note.save
        format.html { redirect_to subject_topic_notes_path(@subject.id, @topic.id), notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @note = @topic.notes.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to subject_topic_notes_path(@subject.id, @topic.id), notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @user = User.find(current_user.id)
    @subject = @user.subjects.find(params[:subject_id])
    @topic = @subject.topics.find(params[:topic_id])
    @note = @topic.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to subject_topic_notes_path(@subject.id, @topic.id) }
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
