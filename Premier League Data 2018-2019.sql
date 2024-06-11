SELECT *
FROM `epl_table_stats_unraw`
ORDER BY `Current Club`;

CREATE TEMPORARY TABLE `Duplicate`
SELECT *, ROW_NUMBER() OVER(PARTITION BY `full_name`, `age`, `Current Club`, `position`, `birthday_GMT`) AS `Row Number`
FROM `epl_table_stats_unraw`
ORDER BY `Row Number` DESC;

WITH `Ranked` AS
(SELECT DISTINCT `Current Club`, TRIM(`Current Club`)
FROM `epl_table_stats_unraw`
GROUP BY `Current Club`
ORDER BY 1)

SELECT *, ROW_NUMBER() OVER()
FROM `Ranked`
;

WITH avg_mins AS
(SELECT `full_name`, `minutes_played_overall`, `birthday_GMT`, SUBSTR(`birthday_GMT`, 1, 4) AS `birth_year`
FROM `epl_table_stats_unraw`
WHERE `minutes_played_overall` > 10
ORDER BY 3 DESC)

SELECT *
FROM avg_mins
WHERE `birth_year` > 1999
;