require 'htmlentities'

class TravelAdvicePresenter < MultipagePresenter
  include ActionView::Helpers::TextHelper

  def_delegators :content,
                 :alert_status,
                 :change_description,
                 :country,
                 :current_part,
                 :email_signup_link,
                 :document,
                 :image,
                 :next_part,
                 :previous_part,
                 :reviewed_at,
                 :summary

  def web_url
    controller.url_for(only_path: false)
  end

  def atom_change_description
    simple_format(HTMLEntities.new.encode(content.change_description, :basic, :decimal))
  end

  def navigation_parts
    nav_parts = [Part.new(slug: nil, title: "Summary", body: nil)]
    nav_parts + parts
  end

  def last_reviewed_or_updated_at
    if reviewed_at
      Date.parse(reviewed_at)
    else
      updated_at
    end
  end
end
