ruleset more_trips {
	meta {
		name "more trips"
		description <<
			Part 2 for the pico lab
		>>
		author "Davis Pearson"
		logging on
	}

	rule process_trip {
		select when car new_trip
		pre {
			mlg = event:attr("mileage")
		}
		send_directive("trip") with
		trip_length = mlg
	}
}