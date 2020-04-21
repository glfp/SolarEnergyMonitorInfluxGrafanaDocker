FV Complete - Graph

[A]
SELECT max("value") FROM "data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND "value" > 0 AND $timeFilter GROUP BY time($__interval) fill(previous) tz('Europe/Rome')
alias Produzione Solare

Min time interval: 1d
Relative Time: 1M/d