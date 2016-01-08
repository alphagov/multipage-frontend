require 'htmlentities'

class TravelAdvicePresenter < MultipagePresenter
  include ActionView::Helpers::TextHelper

  def web_url
    controller.url_for(only_path: false)
  end

  def atom_change_description
    simple_format(HTMLEntities.new.encode(content.change_description, :basic, :decimal))
  end
end
