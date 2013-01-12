class IssueTopicsController < ApplicationController
  before_filter :authenticate_user!, only:[:new, :create, :update, :destroy]

  def index
    repository = Repository.find(params[:repository_id])
    @issue_topics = repository.issue_topics
  end

  def show
    @issue_topic = IssueTopic.find(params[:id])
    @issue_comments = @issue_topic.issue_comments
  end

  def new
    @repository = Repository.find(params[:repository_id])
    @issue_topic = IssueTopic.new
  end

  def create
    @issue_topic = current_user.issue_topics.build(params[:issue_topic])
    @issue_topic.repository = Repository.find(params[:repository_id])
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
end
