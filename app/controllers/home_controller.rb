class HomeController < ApplicationController
  include BungakuHub::Test
  def index
    @text = "This is home controller"
    hoge
  end
end
