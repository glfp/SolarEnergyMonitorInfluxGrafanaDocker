FV Cockpit - Multigraph Bar

[A]
SELECT difference(last("value")) FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Import') AND $timeFilter GROUP BY time($__interval) fill(null) tz('Europe/Rome')
alias prelievo

[B]
SELECT difference(last("value")) FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Export') AND $timeFilter GROUP BY time($__interval) fill(null) tz('Europe/Rome')
alias immission

[C]
SELECT difference(last("value")) FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'Import') AND $timeFilter GROUP BY time($__interval) fill(null) tz('Europe/Rome')
alias produzion

[D]
SELECT mean("prelievo") + mean("produzione") - mean("immissione") as "consumo"  FROM
( 
SELECT difference(last("value")) as "prelievo" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Import') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
), 
(
SELECT difference(last("value")) as "immissione" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Export') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
),
(
SELECT difference(last("value")) as "produzione" FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'Import') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
)
GROUP BY time(1d) fill(null) tz('Europe/Rome')
alias consumo

[E]
SELECT mean("produzione") - mean("immissione") as "autoconsumo"  FROM
( 
SELECT difference(last("value")) as "prelievo" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Import') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
), 
(
SELECT difference(last("value")) as "immissione" FROM "autogen"."data" WHERE ("device" = 'SDM1.1' AND "type" = 'Export') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
),
(
SELECT difference(last("value")) as "produzione" FROM "autogen"."data" WHERE ("device" = 'SDM1.2' AND "type" = 'Import') AND $timeFilter GROUP BY time(1d) fill(null) tz('Europe/Rome')
)
GROUP BY time(1d) fill(null) tz('Europe/Rome')
alias autoconsumo


Relative Time: now/d