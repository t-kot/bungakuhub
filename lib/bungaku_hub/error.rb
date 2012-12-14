module BungakuHub
  class Error
    
    def initialize(stderr)
      @message = stderr.read
    end

    def try_raise
      raise GitError.new(@message) unless @message.blank?
    end

  end
end
