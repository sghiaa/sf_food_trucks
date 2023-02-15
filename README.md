# SfFoodTrucks

## Goal
To provide a random food truck selection, to make decisions easier. 

## Technical decisions
1) This app currently reads a csv and does filtering at the controller level.  This could be improved by adding a database,
but for the purposes of this exercise I thought reading a csv would suffice.  
2) There are duplicated address/restaurants in the suggestion lists.  This is a result of the way the CSV encodes locations.
I made the assumption that the location descriptions are grouped by distance to other food trucks, because in Boston there are
several hubs of food trucks.  Grouping by Address did not usually give any overlap between truck locations.  These could be 
deduped, but I thought maybe it would be useful to see how many options are at a location.
2) Tests can be run with `mix test`, although there are only happy path tests at the moment.
3) Layout is very basic becuase I didn't want to risk accidentally spending hours wrestling with css.


## Local development
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

