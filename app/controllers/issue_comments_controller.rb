#coding: utf-8
class IssueCommentsController < ApplicationController
  before_filter :authenticate_user!, only:[:create]
  def create
    @issue_topic = IssueTopic.find(params[:issue_topic_id])
    @issue_comment = @issue_topic.issue_comments.build(params[:issue_comment])
    respond_to do |format|
      if @issue_comment.save
        flash[:notice] = '成功'
      else
        flash[:alert] = "失敗"
      end
      format.html {redirect_to issue_topic_path(@issue_topic)}
    end
  end
end
