FV Cockpit Graph
FV Complete Graph

[A]
SELECT mean("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous) tz('Europe/Rome')
alias prelievo_immissione

[B]
SELECT mean("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous) tz('Europe/Rome')
alias solare

[C]
SELECT mean("prelievo_immissione") + mean("solare") as "consumo"  FROM
( 
SELECT mean("value") as  "prelievo_immissione" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)  tz('Europe/Rome')
), 
(
SELECT mean("value") as "solare" FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1')  AND $timeFilter  GROUP BY time($__interval) fill(previous) tz('Europe/Rome')
)
GROUP BY time($__interval) fill(null)
alias consumo