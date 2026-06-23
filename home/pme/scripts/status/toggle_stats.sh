#!/usr/bin/env bash

FLAG="/tmp/dwmblocks_stats"

if [ -f "$FLAG" ]; then
	rm "$FLAG"
else
	touch "$FLAG"
fi

kill -RTMIN+5 $(pidof dwmblocks)
