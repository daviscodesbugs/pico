ruleset track_trips {
	meta {
		name "track trips"
		description <<
			Part 1 for the pico lab
		>>
		author "Davis Pearson"
		logging on
	}

	rule process_trip {
		select when echo message
		pre {
			mlg = event:attr("mileage")
		}
		send_directive("trip") with
		trip_length = mlg
	}
}