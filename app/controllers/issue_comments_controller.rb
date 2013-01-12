class IssueCommentsController < ApplicationController
  before_filter :authenticate_user!, only:[:create]
  def create
    issue_topic = IssueTopic.find(params[:issue_topic_id])
    @issue_comment = issue_topic.issue_comments.build(params[:issue_comment])
    respond_to do |format|
      if @issue_comment.save
        format.html {redirect_to issue_topic_path(issue_topic)}
      else
        format.html {render "issue_topics/index"}
      end
    end
  end
end
