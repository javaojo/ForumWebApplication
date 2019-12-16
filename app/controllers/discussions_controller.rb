class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
#Use for DRY methodology each method will find a channel to display in each individual view
  before_action :find_channels, only: [:index, :show, :new, :edit]
  #Only the index and show views where the user do not need to be logged in
  #to be able to view the webpage
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @discussions = Discussion.all.order('created_at desc')
      #Displays the channels in the view for the users to be able to access

  end

#for the show page, displays all the discussions and the channels
  def show
    @discussions = Discussion.all.order('created_at desc')
  end

  # buiilds a new object in memory so the view can be displayed without being stored in the database
  def new
    @discussion = current_user.discussions.build
  end

  def edit
  end

#Creates a discussion to be saved in the database and display to user weather their Discussions page has been created or not.
  def create
    @discussion =current_user.discussions.build(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

#Updates a and renders a discussion page and redircts the user to the newly upadated webpage.
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        #if an error is caught in making a webpage then an error is thrown to the user to display
        #Incorrect information has been passed through.
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deletes a discussion page and redirects the user back to the homepage where the discussion is removed from the database.
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def find_channels
    @channels = Channel.all.order('created_at desc')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def discussion_params
    params.require(:discussion).permit(:title, :content, :channel_id)
  end

end
