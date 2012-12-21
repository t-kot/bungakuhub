class DiffsController < ApplicationController
  
  def show
    @kommit1 = Kommit.find(params[:kommit_id])
    @kommit2 = Kommit.find(params[:id])
    @repository = @kommit1.repository
    @diffs = @repository.repo.diff(@kommit1.revision, @kommit2.revision)
    raise BungakuHub::GitError.new("no diff found") if @diffs.blank?
    render "/kommits/diff/"
  end

end
