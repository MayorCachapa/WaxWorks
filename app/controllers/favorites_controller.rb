class FavoritesController < ApplicationController
    def index
        @favorites = Favorite.all
    end
    
    def create
        @favorite = Favorite.new
        @favorites.user = current_user
        @favorites.release = params[:release_id]
    
        if @favorite.save
          redirect_to release_path(@favorite.release)
        else
          render :index, status: :unprocessable_entity
        end
    end
    
    def update
    end
end
