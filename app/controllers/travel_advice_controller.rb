class TravelAdviceController < MultipageController
private
  def base_path
    "/foreign-travel-advice/#{params[:country_slug]}"
  end
end
