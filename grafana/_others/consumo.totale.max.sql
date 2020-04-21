FV Cockpit STAT

[A]
SELECT max("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
alias sdm_cs

[B]
SELECT max("value") FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
alias sdm_fv

[C]
A['sdm_cs'] + ( B['sdm_fv'] > 0 ? B['sdm_fv'] : 0)

SELECT mean("sdm_cs") + mean("sdm_fv") as "consumomax"  FROM
( 
SELECT max("value") as "sdm_cs" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
), 
(
SELECT max("value") as "sdm_fv" FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'PowerL1') AND $timeFilter GROUP BY time($__interval) fill(previous)
)
GROUP BY time($__interval) fill(null)
alias consumomax

