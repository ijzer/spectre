defmodule Spectre.API.Spectre do
	use Maru.Router
  prefix :api
	
	mount Spectre.API.Spectre.V1
end
