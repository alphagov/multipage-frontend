class RelatedLinksPresenter
  def breadcrumbs
    [
      {
        title: "Home",
        url: "/",
      },
      {
        title: "Passports, travel and living abroad",
        url: "/browse/abroad",
      },
      {
        title:  "Travel abroad",
        url:  "/browse/abroad/travel-abroad",
      },
      {
        title:  "Foreign travel advice",
        url:  "/foreign-travel-advice",
      },
    ]
  end

  def related_links
    [
      {
        title: "Travel abroad",
        url: "/browse/abroad/travel-abroad",
        items: [
          {
            title: "Driving abroad",
            url: "/driving-abroad"
          },
          {
            title: "Hand luggage restrictions at UK airports",
            url: "/hand-luggage-restrictions",
          },
        ]
      },
      {
        title: "Passports, travel and living abroad",
        url: "/browse/abroad",
        items: [
          {
            title: "Renew or replace your adult passport",
            url: "/renew-adult-passport"
          }
        ]
      }
    ]
  end
end
