module ListingsHelper
  def listing_score(listing)
    condition_weight = 2.0 / 3.0
    sleeve_condition_weight = 1.0 / 3.0

    condition_scores = {
      "Excellent" => 4,
      "Good" => 3,
      "Fair" => 2,
      "Damaged" => 1
    }

    total_score = (condition_scores[listing.condition] * condition_weight) + (condition_scores[listing.sleeve_condition] * sleeve_condition_weight)
    total_score.round(2)
  end
end
