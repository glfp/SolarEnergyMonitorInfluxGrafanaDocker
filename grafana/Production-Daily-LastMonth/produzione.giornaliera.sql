FV Complete - Graph Bars

[A]
SELECT difference(last("value")) FROM "data" WHERE ("device" = 'SDM1.2' AND "type" = 'Import') AND $timeFilter GROUP BY time(24h) fill(previous) tz('Europe/Rome')
alias Produzione Solare

Min time interval: 1d
Relative Time: 1M