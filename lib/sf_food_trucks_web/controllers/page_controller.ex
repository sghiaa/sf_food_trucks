defmodule SfFoodTrucksWeb.PageController do
  use SfFoodTrucksWeb, :controller

  def load_csv(csv) do
    csv
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode(headers: true)
  end

  def get_restaurant(data) do
    data
    |> Stream.map(fn {:ok, r} -> %{ id: r["locationid"], name: r["Applicant"], address: r["Address"], description: r["LocationDescription"] } end)
    |> Enum.take_random(1)
    |> List.first
  end

  def get_restaurant(data, id) do
    data
    |> Stream.map(fn {:ok, r} -> %{ id: r["locationid"], name: r["Applicant"], address: r["Address"], description: r["LocationDescription"] } end)
    |> Enum.filter(fn r -> r.id == id end)
    |> List.first
  end

  def all_locations(data, name) do
    data
    |> Stream.reject(fn {:ok, r} -> r["Applicant"] != name end)
    |> Stream.map(fn {:ok, r} -> %{ id: r["locationid"], name: r["Applicant"], address: r["Address"], description: r["LocationDescription"] } end)
  end

  def other_trucks(data, id) do
    {:ok, location} = data
    |> Stream.reject(fn {:ok, l} -> l["locationid"] != id end)
    |> Enum.to_list
    |> List.first

    [desc | _] = location["LocationDescription"]
    |> String.split(":")

    data
    |> Stream.reject(fn {:ok, r} ->
      [location | _] = String.split(r["LocationDescription"], ":")
       desc != location
    end)
    |> Stream.map(fn {:ok, r} -> %{ id: r["locationid"], name: r["Applicant"], address: r["Address"], description: r["LocationDescription"] } end)
  end

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    data = "../../../Mobile_Food_Facility_Permit.csv"
          |> load_csv

    r = data
        |> get_restaurant()

    os = data
         |> other_trucks(r[:id])

    rs = data
        |> all_locations(r[:name])

    render(conn, "index.html", restaurant: r, all_locations: rs, other_trucks: os)
  end

  def show(conn,  %{"id" => id}) do
    data = "../../../Mobile_Food_Facility_Permit.csv"
          |> load_csv

    r = data
        |> get_restaurant(id)

    os = data
         |> other_trucks(id)

    rs = data
        |> all_locations(r[:name])
    render(conn, "index.html", restaurant: r, all_locations: rs, other_trucks: os)
  end
end
