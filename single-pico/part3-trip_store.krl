ruleset trip_store {
	meta {
		name "more trips"
		description <<
			Part 2 for the pico lab
		>>
		author "Davis Pearson"
		logging on
		provides trips, long_trips, short_trips
		shares trips, long_trips, short_trips
	}

	global {
		trips = function() {
			ent:trips
		}
		long_trips = function() {
			ent:long_trips
		}
		short_trips = function() {
			alltrips = trips().filter(function(x) {
				long.trips().none(function(y) {
					x{"time"} eq y{"time"}
				})
			})
		}
	}

	rule collect_trips {
		select when explicit trip_processed
		pre {
			trip = {
				"length": event:attr("mileage"),
				"time": event:attr("timestamp")
			}
		}
		always {
			ent:trips := ent:trips.append(trip)
		}
	}

	rule collect_long_trips {
		select when explicit found_long_trip
		pre {
			long_trip = {
				"length": event:attr("mileage"),
				"time": event:attr("timestamp")
			}
		}
		send_directive("long_trip") with
		trip_length = event:attr("mileage")
		always {
			ent:long_trips := ent:long_trips.append(long_trip)
		}
	}

	rule clear_trips {
		select when car trip_reset
		fired {
			ent:trips := [];
			ent:long_trips := []
		}
	}
}
