WITH DailyLog AS (
    SELECT
        emp_id,
        DATE(STR_TO_DATE(timestamp, '%Y-%m-%d %H:%i:%s')) AS work_date,
        MIN(STR_TO_DATE(timestamp, '%Y-%m-%d %H:%i:%s')) AS log_in_time,
        MAX(STR_TO_DATE(timestamp, '%Y-%m-%d %H:%i:%s')) AS log_out_time
    FROM
        attendance
    GROUP BY
        emp_id,
        work_date
),
WeekendWork AS (
    SELECT
        emp_id,
        work_date,
        FLOOR(
            TIMESTAMPDIFF(SECOND, log_in_time, log_out_time) / 3600
        ) AS daily_hours
    FROM
        DailyLog
    WHERE
        DAYOFWEEK(work_date) IN (1, 7) 
)
SELECT
    emp_id,
    SUM(daily_hours) AS weekend_hours_worked
FROM
    WeekendWork
GROUP BY
    emp_id
ORDER BY
    weekend_hours_worked DESC;