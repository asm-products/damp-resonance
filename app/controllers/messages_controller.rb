class MessagesController < ApplicationController
before_filter :authenticate_user!

# GET /message/new
def new

    @request = Request.find(params[:request])
    @message = current_user.messages.new
    @user = @request.user
end

# POST /message/create
def create

#@user = User.find(params[:user])
@body = params[:body]
@subject = params[:subject]

current_user.send_message(current_user, params[:body], params[:subject])
flash[:notice] = "Message has been sent!"
redirect_to :conversations
end
end
