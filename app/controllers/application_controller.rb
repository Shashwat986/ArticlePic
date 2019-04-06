class ApplicationController < ActionController::Base

  protected

  def not_found
    # raise ActionController::RoutingError.new('Not Found')
    head 404
  end

  def forbidden
    head 403
  end
end
