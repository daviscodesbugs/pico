ruleset more_trips {
	meta {
		name "more trips"
		description <<
			Part 2 for the pico lab
		>>
		author "Davis Pearson"
		logging on
	}

	global {
		long_trip = 100
	}

	rule process_trip is active {
		select when car new_trip
		pre {
			mlg = event:attr("mileage")
		}
		send_directive("trip") with
		trip_length = mlg
		fired {
			raise explicit event "trip_processed"
			attributes event:attrs()
		}
	}

	rule find_long_trips is active {
		select when explicit trip_processed
		pre {
			mlg = event:attr("mileage")
		}
		fired {
			raise explicit event "found_long_trip"
			attributes event:attrs()
			if (mlg > long_trip)
		}
	}

	rule process_long_trip {
		select when explicit found_long_trip
		send_directive("Found a long trip!")
	}
}