FV Cockpit GAUGE
FV Complete GAUGE

[A]
SELECT last("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
alias: sdm_cs

[B]
SELECT last("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
alias: sdm_fv

[C]
SELECT mean("sdm_cs") + mean("sdm_fv") as "consumomax"  FROM
( 
SELECT last("value") as "sdm_cs" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
), 
(
SELECT last("value") as "sdm_fv" FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND "value" >= 0 AND  $timeFilter GROUP BY time($__interval) fill(previous)
)
GROUP BY time($__interval) fill(null)