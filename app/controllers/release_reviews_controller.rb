class ReleaseReviewsController < ApplicationController
    def new
        @review = ReleaseReview.new
    end

    def create
        @review = ReleaseReview.new(review_params)
        @review.user = current_user
        @review.release = Release.find(params[:release_id])

        if @review.save
            redirect_to release_path(@review.release)
        else
            redirect_to release_path(@review.release), status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
    end

    def destroy
        @review = ReleaseReview.find(params[:id])
        @review.destroy!
    end

    private

    def review_params
        params.require(:release_review).permit(:content, :rating)
    end
end
  