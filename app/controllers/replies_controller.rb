class RepliesController < ApplicationController

  before_action :authenticate_user!
  #Finds the reply and the discussion through each of the views without having to declare them in each method.
  before_action :set_reply, only: [:edit, :update, :show, :destroy]
  before_action :set_discussion, only: [:create, :edit, :show, :update, :destroy]


#Finds the reply that is on the discussion and it passes the params of the reply and discussion_id in order
#to create a reply within the discussion.
  def create
    @reply = @discussion.replies.create(params[:reply].permit(:reply, :discussion_id))
    #sets the user_id to the reply
    @reply.user_id = current_user.id

    respond_to do |format|
      if @reply.save
        #once the reply is saved to database the user is redirected to thr discussion page rendered
        #with the newly added reply.
        format.html { redirect_to discussion_path(@discussion) }
        format.js # renders create.js.erb
      else
        format.html { redirect_to discussion_path(@discussion), notice: "Reply did not save. Please try again."}
        format.js
      end
    end
  end

  def new
  end

#Gets the replies id to find the discussion to thendelete the associated records
  def destroy
    @reply = @discussion.replies.find(params[:id])
    @reply.destroy
    #redircts user to homepage after deletion.
    redirect_to discussion_path(@discussion)
  end

  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @reply = @discussion.replies.find(params[:id])
  end

#
  def update
    @reply = @discussion.replies.find(params[:id])
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to discussion_path(@discussion), notice: 'Reply was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private
#Finds the discussion on the reply page and get's the discussion
  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end
#Gets the reply
  def set_reply
    @reply = Reply.find(params[:id])
  end
#defines the strong parameters
  def reply_params
    params.require(:reply).permit(:reply)
  end
end
