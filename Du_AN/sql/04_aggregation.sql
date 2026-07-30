-- ====================================================================
-- DỰ ÁN 1 (AI21301) - NHÓM 1
-- Đề tài: Phân tích ứng dụng Google Play Store
-- Script: 04_aggregation.sql
-- Mô tả: Các truy vấn tổng hợp (Aggregation) dữ liệu mẫu trực tiếp từ PostgreSQL
-- Phù hợp với Notebook 02 (02_postgresql_pipeline.ipynb - Mục IX)
-- ====================================================================

-- 1. Thống kê Top 10 Thể loại (Category) có nhiều ứng dụng nhất và điểm Rating trung bình
SELECT 
    category,
    COUNT(*) AS total_apps,
    ROUND(AVG(rating), 2) AS avg_rating
FROM apps
GROUP BY category
ORDER BY total_apps DESC
LIMIT 10;

-- 2. Thống kê tổng số nhận xét Tích cực / Tiêu cực / Trung tính theo từng Category từ View
SELECT 
    category,
    COUNT(app_id) AS total_apps,
    SUM(total_reviews_analyzed) AS grand_total_reviews,
    SUM(positive_reviews) AS total_positive_reviews,
    SUM(negative_reviews) AS total_negative_reviews,
    SUM(neutral_reviews) AS total_neutral_reviews,
    ROUND(AVG(avg_sentiment_polarity), 4) AS overall_avg_polarity
FROM view_app_sentiment_summary
WHERE total_reviews_analyzed > 0
GROUP BY category
ORDER BY grand_total_reviews DESC
LIMIT 10;

-- 3. Truy vấn danh sách ứng dụng có lượt tải (Installs) và đánh giá cảm xúc tích cực nhiều nhất
SELECT 
    app_name,
    category,
    rating,
    installs,
    total_reviews_analyzed,
    positive_reviews,
    avg_sentiment_polarity
FROM view_app_sentiment_summary
WHERE total_reviews_analyzed >= 10
ORDER BY positive_reviews DESC, avg_sentiment_polarity DESC
LIMIT 10;
