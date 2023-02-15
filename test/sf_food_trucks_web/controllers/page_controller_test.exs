defmodule SfFoodTrucksWeb.PageControllerTest do
  use SfFoodTrucksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Where should we eat"
  end

  test "gets a restaruant from a provided csv" do
    testfile = "../../../test/sf_food_trucks_web/controllers/test_restaurant.csv"
    assert SfFoodTrucksWeb.PageController.get_restaurant(testfile) ==
       %{ name: "Ziaurehman Amini", address: "5 THE EMBARCADERO" }
  end
end
