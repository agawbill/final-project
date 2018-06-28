
class ApplicationController < ActionController::Base
  protect_from_forgery


  # before_filter :set_config
  Tmdb::Api.key("720b022cdc841c69c719e5c1b854fd67")

  def set_config
  	@configuration = Tmdb::Configuration.new
  end

end
