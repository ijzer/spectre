defmodule Spectre.DatabaseTest do
	use ExUnit.Case, async: false
	alias Spectre.{Artist, Album, Song}

  setup do
		run_redis_file("redis-test-setup")
    on_exit(fn -> run_redis_file("redis-test-teardown") end)
	end

	test "get resources from database" do
		{:ok, artists} = Spectre.Database.get_collection("test:artists")
    assert artists == [%{id: 1, name: "Ezra Furman"},
											 %{id: 2, name: "Indie/Rock Playlist"},
											 %{id: 3, name: "Don Caballero"},
											 %{id: 4, name: "2 Bad Mice"},
											 %{id: 5, name: "Blame"},
											 %{id: 6, name: "Kaotic Chemistry"}]
	end
	
  test "get resource from database" do
		albums = for id <- [2,7,8] do
			{:ok, album} = Spectre.Database.get_resource("test:albums:#{id}")
			album
		end
		assert albums == [%{id: 2, name: "Mysterious Power", tracks: 12},
										 %{id: 7, name: "American Don", tracks: 9},
										 %{id: 8, name: "For Respect", tracks: 11}]
  end

	test "add resource to database" do
		{:ok, id} = Spectre.Database.create_resource("test:artists", [name: "AFP"])
		{:ok, artist} = Spectre.Database.get_resource("test:artists:#{id}")
		assert artist == %{id: id, name: "AFP"}
		{:ok, added} = Redix.command(Spectre.Redis, ~w(sismember test:artists #{id}))
		assert added
	end

  test "update resource in database" do
    :ok = Spectre.Database.update_resource("test:albums:3", [tracks: 2000])
		{:ok, album} = Spectre.Database.get_resource("test:albums:3")
		assert album[:tracks] == 2000
	end

	test "delete resource from database" do
		:ok = Spectre.Database.delete_resource("test:albums:2")
		{:error, _} = Spectre.Database.get_resource("test:albums:3")
		{:ok, member} = Redix.command(Spectre.Redis, ~w(sismember test:albums #{id}))
		refute member
	end

	test "sort returned resources" do
	end

	test "filter returned resource by field" do
	end

	test "paginate returned resources" do
	end

	test "get resources by relationship" do
	end

	def run_redis_file(file) do
		Porcelain.exec("redis-cli", ["--pipe"],
									 in: File.stream!(file),
									 out: nil)
	end
end

