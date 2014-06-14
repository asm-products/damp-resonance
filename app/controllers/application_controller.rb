class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   
  def conversations_params
     params.require(:conversations).permit(:recipients, :body, :subject,
     :conversations, :conversation, :message)
  end

end
