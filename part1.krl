ruleset echo {
	meta {
		name "echo"
		description <<
			Part 1 for the pico lab
		>>
		author "Davis Pearson"
		logging on
	}

	rule hello {
		select when echo hello
		send_directive("say") with
		something = "Hello World"
	}

	rule message {
		select when echo message
		pre {
			inp = event:attr("input")
		}
		send_directive("say") with
		something = inp
	}
}