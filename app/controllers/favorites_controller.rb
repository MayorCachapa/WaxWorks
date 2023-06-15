class FavoritesController < ApplicationController
    def index
        @favorites = Favorite.where(user: current_user)
    end

    def create
        @favorite = Favorite.new
        @favorite.user = current_user
        @favorite.release = Release.find(params[:release_id])

        if favorite_already_exists?
          redirect_to favorites_path, notice: "Release already in favorites."
        elsif @favorite.save
          if request.referer.include?('release')
            redirect_to release_path(@favorite.release), notice: "Release added to favorites list" and return
          end
          redirect_to listings_path
        else
          redirect_to favorites_path, status: :unprocessable_entity
        end
    end

    def update
    end

    def destroy
      @favorite = Favorite.find(params[:id])
      @release = @favorite.release
      @favorite.destroy!
      if request.referer.include?('release')
        redirect_to release_path(@release)
      else
        redirect_to listings_path
      end
    end

    private

    def favorite_already_exists?
      Favorite.exists?(user: current_user, release_id: @favorite.release_id)
    end
end
