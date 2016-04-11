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

  # FIXME: Update publishing app UI and remove from content
  # Change description is used as "Latest update" but isn't labelled that way
  # in the publisher. The frontend didn't add this label before.
  # This led to users appending (in a variety of formats)
  # "Latest update:" to the start of the change description. The frontend now
  # has a latest update label, so we can strip this out.
  # Avoids: "Latest update: Latest update - …"
  def latest_update
    return nil unless change_description.present?
    change_description.sub(/^Latest update:?\s-?\s?/i, '').tap do |latest|
      latest[0] = latest[0].capitalize
    end
  end
end
