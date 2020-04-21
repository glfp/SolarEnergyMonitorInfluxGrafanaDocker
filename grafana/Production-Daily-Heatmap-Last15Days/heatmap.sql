FV Complete - Heatmap
Format: time series bucket
Color: spectrum - Orange
Color Scale: 0-6100 

[A]
SELECT mean("value") FROM "data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous) tz('Europe/Rome')
alias solar

Relative Time: 15d