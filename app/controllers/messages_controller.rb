# File created 11/23 by Troy Paschal:Handles displaying and sending messages in a chat
# Edited 12/4 by Troy Paschal:Added check for sending empty message
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation
  before_action :set_message, only: [ :destroy ]

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.includes(:sender) || []
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
    @message.recipient = @conversation.sender == current_user ? @conversation.recipient : @conversation.sender

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      @messages = @conversation.messages.includes(:sender)
      flash.now[:alert] = "Message could not be sent."
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @message.sender == current_user || @message.recipient == current_user
      @message.destroy
      flash[:notice] = "Message deleted successfully."
    end
    redirect_to conversation_messages_path(@conversation)
  end


  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def set_message
    @message = @conversation.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
