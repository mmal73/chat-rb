class MessagesController < ApplicationController
  before_action :getroom

  def new
    @message = @room.messages.build
  end

  def create
    @message = @room.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to @room, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  private

  def getroom
    @room = Room.find(params[:room_id])
  end
end
