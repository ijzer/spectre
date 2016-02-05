defmodule Spectre.API.Spectre.V1 do
	use Maru.Router

	version "v1"
	mount Spectre.API.Spectre.V1.System
end
