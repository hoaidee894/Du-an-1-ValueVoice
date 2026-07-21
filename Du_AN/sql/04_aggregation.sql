-- SQL Script placeholder
CREATE INDEX IF NOT EXISTS idx_apps_app_name ON apps(app_name);
CREATE INDEX IF NOT EXISTS idx_apps_category ON apps(category);


-- Thống kê 1: Theo Category
SELECT 
    category,
    COUNT(*) AS total_apps,
    ROUND(AVG(rating), 2) AS avg_rating
FROM apps
GROUP BY category
ORDER BY total_apps DESC;

-- Thống kê 2: Tỷ lệ Free vs Paid và Giá trung bình
SELECT 
    type,
    COUNT(*) AS total_apps,
    ROUND(AVG(CAST(price AS NUMERIC)), 2) AS avg_price
FROM apps
WHERE type IS NOT NULL AND type <> ''
GROUP BY type;
