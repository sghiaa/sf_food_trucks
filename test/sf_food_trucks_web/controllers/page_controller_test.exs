defmodule SfFoodTrucksWeb.PageControllerTest do
  use SfFoodTrucksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Where should we eat"
  end

  test "GET /735318", %{conn: conn} do
    conn = get(conn, "/735318")
    assert html_response(conn, 200) =~ "Ziaurehman Amini"
  end

  test "gets a restaruant from a provided csv" do
    testfile = "../../../test/sf_food_trucks_web/controllers/test_restaurant.csv"
    restaurant = testfile
    |> SfFoodTrucksWeb.PageController.load_csv
    |> SfFoodTrucksWeb.PageController.get_restaurant
    assert restaurant ==
       %{id: "735318", name: "Ziaurehman Amini", address: "5 THE EMBARCADERO", description: "MARKET ST: DRUMM ST intersection" }
  end
end
