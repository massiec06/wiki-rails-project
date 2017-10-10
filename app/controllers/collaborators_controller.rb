class CollaboratorsController < ApplicationController
  before_action :set_wiki

    # def index
    #   @users = User.where("id is not ?", current_user.id)
    # end

    def create
      collaborator = @wiki.collaborators.build(collaborator_params)

      if collaborator.save
        flash[:notice] = "Collaborators adjusted."
      else
        flash[:alert] = "Collaborators Unchanged."
      end

      redirect_to @wiki
    end

    def destroy
      collaborator = @wiki.collaborators.find(params[:id])

      if collaborator.destroy
        flash[:notice] = "You removed a collaborator"
      else
        flash[:error] = "There was a problem removing this collaborator"
      end

      redirect_to @wiki
    end


    private

    def set_wiki
      @wiki = Wiki.find(params[:wiki_id])
    end

    def collaborator_params
      params.require(:collaborator).permit(:user_id)
    end
end
