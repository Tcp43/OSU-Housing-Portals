# File created 11/23 by Troy Paschal:Handles displaying and creating chats
# Edited 12/4 by Troy Paschal: Added check for ensuring user doesnt create chat with themselves
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
  end

  def new
    @users = User.where.not(id: current_user.id)
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.get(current_user.id, params[:recipient_id])
    @users = User.where.not(id: current_user.id)
    if @conversation.save
      redirect_to conversation_messages_path(@conversation), notice: "New conversation created."
    else
      flash[:alert] = "Failed to create conversation."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    if @conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id
      @conversation.destroy
      redirect_to conversations_path, notice: "Conversation deleted successfully."
    else
      redirect_to conversations_path, alert: "You are not authorized to delete this conversation."
    end
  end
end
