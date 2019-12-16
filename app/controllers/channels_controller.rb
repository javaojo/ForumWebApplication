class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]



  def index
    @channels = Channel.all
    @discussions = Discussion.all.order('created_at desc')
  end

#a query to find and display the the discussions where the channel_id in discussions matches
#with the channel id in the display common
  def show
    @discussions = Discussion.where('channel_id = ?', @channel.id)
    @channels = Channel.all
  end


  #Creates a new instance of a channel when called
  def new
    @channel = Channel.new
  end


  def edit
  end


  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        #When a new channel is created it will redirect the user to the page where the channel has been created at
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to channel_path, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:channel)
    end
end
