module BungakuHub::Util
  private
  def try_and_error(err)
    raise err if err.present?
  end
end
