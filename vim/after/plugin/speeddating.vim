if exists(":SpeedDatingFormat")
	1 SpeedDatingFormat %a %b %0d %H:%M:%S %Z %Y

	SpeedDatingFormat %Y-%m-%dT%H:%M:%S

	SpeedDatingFormat %-d %B %Y

	" Date format I use in attribution lines from mutt
	SpeedDatingFormat %H:%M %z %d %b %Y

	" Allow month names by themselves
	SpeedDatingFormat %B

	" Allow weekday names by themselves
	SpeedDatingFormat %A
endif
