class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[job wallet name])
  end

  def show_not_found_errors(exception)
    render json: { error: "#{exception.message} with 'id'=#{params[:id]}" },
           status: :not_found
  end
end
