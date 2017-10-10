class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    exisiting_collab_ids = @collaborators.collect(&:user_id) << current_user.id
    @available_collaborators = User.where('id NOT IN (?)', exisiting_collab_ids)
  end

  def new
    @wiki = Wiki.new
  end

  def create
     @wiki = current_user.wikis.build(wiki_params)
    #  @wiki.title = params[:wiki][:title]
    #  @wiki.body = params[:wiki][:body]
    #  @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = @wiki.errors.full_messages.to_sentence #"There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
     @wiki = Wiki.find(params[:id])
    #  @wiki.title = params[:wiki][:title]
    #  @wiki.body = params[:wiki][:body]

     if @wiki.update(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = @wiki.errors.full_messages.to_sentence #"There was an error saving the wiki. Please try again."
       render :edit
     end
   end

   def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
