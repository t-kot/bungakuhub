class IssueTopicsController < ApplicationController
  layout "repository_menu"
  before_filter :authenticate_user!, only:[:new, :create, :update, :destroy]
  before_filter :load_items, only:[:index, :new, :create]
  before_filter :load_topic, only:[:show, :update, :destroy]

  def index
    @issue_topics = @repository.issue_topics
  end

  def show
    @issue_topic = IssueTopic.find(params[:id])
    @issue_comments = @issue_topic.issue_comments
    @issue_comment = IssueComment.new
  end

  def new
    @issue_topic = IssueTopic.new
  end

  def create
    @issue_topic = current_user.issue_topics.build(params[:issue_topic])
    @issue_topic.repository = @repository
    respond_to do |format|
      if @issue_topic.save
        format.html{ redirect_to issue_topic_path(@issue_topic), notice: t("flash.info.create.notice", model: t("activerecord.models.issue_topic")) }
      else
        format.html {render action: :new}
      end
    end
  end

  def update
  end

  def destroy
  end

  def load_items
    repository_id = params[:repository_id] || params[:id]
    @repository = Repository.find(repository_id)
    @user = @repository.user
    @branch = @repository.master
  end

  def load_topic
    @issue_topic = IssueTopic.find(params[:id])
    @repository = @issue_topic.repository
    @branch  = @repository.master
    @user = @repository.user
  end
end
