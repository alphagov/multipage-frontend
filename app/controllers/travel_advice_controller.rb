class TravelAdviceController < MultipageController
  def show
    expires_in(10.seconds, public: true)
    super
  end

private

  def base_path
    "/foreign-travel-advice/#{params[:country_slug]}"
  end
end
