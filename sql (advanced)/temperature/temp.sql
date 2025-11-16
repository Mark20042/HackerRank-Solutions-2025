SELECT
    MONTH(STR_TO_DATE(record_date, '%Y-%m-%d')) AS month,
    MAX(CASE WHEN data_type = 'max' THEN data_value END) AS 'monthly maximum',
    MIN(CASE WHEN data_type = 'min' THEN data_value END) AS 'monthly minimum',
    ROUND(AVG(CASE WHEN data_type = 'avg' THEN data_value END)) AS 'monthly average'
FROM
    temperature_records
WHERE
    STR_TO_DATE(record_date, '%Y-%m-%d') BETWEEN '2020-07-01' AND '2020-12-31'
GROUP BY
    month
ORDER BY
    month;