class MessagesController < ApplicationController
  before_action :get_room

  def new
    @message = @room.messages.build
  end

  def create
    puts '**************************'
    puts params
    puts '**************************'
    @message = @room.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def message_params
    params.require(:message).permit(:content, :room_id)
  end

  private

  def get_room
    @room = Room.find(params[:room_id])
  end
end
