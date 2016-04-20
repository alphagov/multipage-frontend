### Overview

When a citizen hits [Multipage Frontend][1] the following components are involved in dispatching the request:
- [Multipage Frontend controller][1]
- [Gds API Adapter][2]
- [Content Store][3]

> The controller delegates to the adapter the responsibility of retrieving the content from the Content Store.

In order to reduce the response time, the [Gds API Adapter][2] will cache any GET request to the [Content Store][3] using standard `HTTP` headers.

#### Cache Scenario:

1. An editor updates a document in the [Content Store][3]. This is [usually done by a presenter][4] via the [Publishing API][10].
2. Once the update has been published, a citizen hits [Multipage Frontend][1] requesting the document, so a controller uses the [Gds Api Adapter][2] to [retrieve the requested content from the Content Store](https://github.com/alphagov/multipage-frontend/blob/master/app/controllers/multipage_controller.rb#L3-3).
3. The [Gds API Adapter][2] does not have the document in its cache, so it performs a GET requests to the [Content Store][2]
4. The [Content Store][2] returns the document [with the default cache headers][6], as they have not been overriden in step 1.
5. The adapter [will use those headers to update its cache timestamps][7], and will return the document to the `Controller` (step 2).

#### Travel Advice

Travel advice introduces two updates to the default caching mechanism described above:

1. A Travel Advice `Presenter` sets the caching time to 10 seconds by [overriding the attribute: max_cache_time][8] when editing / creating documents via [Publishing API][10] (step 1)
This way, the adapter will expire any document after 10 seconds (see step 5 above)

2. Multipage Frontend also [expires manually][9] any `GET` requests to `TravelAdviceController` after 10 seconds.

[1]: https://github.com/alphagov/multipage-frontend
[2]: https://github.com/alphagov/gds-api-adapters
[3]: https://github.com/alphagov/content-store
[4]: https://github.com/alphagov/travel-advice-publisher/blob/master/app/presenters/edition_presenter.rb#L23
[5]: https://github.com/alphagov/multipage-frontend/blob/master/app/controllers/multipage_controller.rb#L3-3
[6]: https://github.com/alphagov/content-store/blob/master/app/controllers/content_items_controller.rb#L71-L82
[7]: https://github.com/alphagov/gds-api-adapters/blob/master/lib/gds_api/json_client.rb#L197-234
[8]: https://github.com/alphagov/travel-advice-publisher/blob/master/app/presenters/edition_presenter.rb#L54
[9]: https://github.com/alphagov/multipage-frontend/blob/master/app/controllers/travel_advice_controller.rb#L3-3
[10]: https://github.com/alphagov/publishing-api
