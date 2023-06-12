class FavoritesController < ApplicationController
    def index
        @favorites = Favorite.all
    end

    def create
        @favorite = Favorite.new
        @favorite.user = current_user
        @favorite.release = Release.find(params[:release_id])

        if @favorite.save
          redirect_to favorites_path
        else
          render :index, status: :unprocessable_entity
        end
    end

    def update
    end
end
