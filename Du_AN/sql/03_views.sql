-- ====================================================================
-- DỰ ÁN 1 (AI21301) - NHÓM 1
-- Đề tài: Phân tích ứng dụng Google Play Store
-- Script: 03_views.sql
-- Mô tả: Tạo các Flat View và Aggregated View tích hợp dữ liệu ứng dụng và điểm cảm xúc
-- Phù hợp với Notebook 02 (02_postgresql_pipeline.ipynb)
-- ====================================================================

-- 1. Xóa Views cũ nếu đã tồn tại
DROP VIEW IF EXISTS view_app_sentiment_summary CASCADE;
DROP VIEW IF EXISTS vw_googleplaystore_flat CASCADE;
DROP VIEW IF EXISTS vw_reviews_summary CASCADE;

-- 2. Tạo View chính cho Notebook 02: view_app_sentiment_summary
-- Gom nhóm dữ liệu nhận xét từ bảng 'user_reviews' kết hợp thông tin thuộc tính ứng dụng từ bảng 'apps'
CREATE OR REPLACE VIEW view_app_sentiment_summary AS
SELECT 
    a.app_id,
    a.app_name,
    a.category,
    a.rating,
    a.reviews,
    a.size,
    a.installs,
    a.type,
    a.price,
    a.content_rating,
    a.genres,
    a.last_updated,
    COUNT(r.review_id) AS total_reviews_analyzed,
    ROUND(AVG(r.sentiment_polarity), 4) AS avg_sentiment_polarity,
    ROUND(AVG(r.sentiment_subjectivity), 4) AS avg_sentiment_subjectivity,
    SUM(CASE WHEN r.sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_reviews,
    SUM(CASE WHEN r.sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_reviews,
    SUM(CASE WHEN r.sentiment = 'Neutral' THEN 1 ELSE 0 END) AS neutral_reviews
FROM apps a
LEFT JOIN user_reviews r ON a.app_id = r.app_id
GROUP BY a.app_id, a.app_name, a.category, a.rating, a.reviews, a.size, a.installs, a.type, a.price, a.content_rating, a.genres, a.last_updated;

-- 3. Tạo View tương thích phụ: vw_reviews_summary
CREATE OR REPLACE VIEW vw_reviews_summary AS
SELECT 
    app,
    COUNT(*) AS total_reviews_count,
    ROUND(AVG(NULLIF(sentiment_polarity, '')::NUMERIC), 4) AS avg_sentiment_polarity,
    ROUND(AVG(NULLIF(sentiment_subjectivity, '')::NUMERIC), 4) AS avg_sentiment_subjectivity,
    SUM(CASE WHEN sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_reviews_count,
    SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_reviews_count,
    SUM(CASE WHEN sentiment = 'Neutral' THEN 1 ELSE 0 END) AS neutral_reviews_count
FROM googleplaystore_user_reviews
WHERE app IS NOT NULL AND translated_review IS NOT NULL
GROUP BY app;

-- 4. Tạo View tương thích phụ: vw_googleplaystore_flat
CREATE OR REPLACE VIEW vw_googleplaystore_flat AS
SELECT 
    a.app,
    a.category,
    a.rating,
    a.reviews,
    a.size,
    a.installs,
    a.type,
    a.price,
    a.content_rating,
    a.genres,
    a.last_updated,
    a.current_ver,
    a.android_ver,
    COALESCE(r.total_reviews_count, 0) AS total_user_reviews,
    COALESCE(r.avg_sentiment_polarity, 0.0) AS avg_sentiment_polarity,
    COALESCE(r.avg_sentiment_subjectivity, 0.0) AS avg_sentiment_subjectivity,
    COALESCE(r.positive_reviews_count, 0) AS positive_reviews_count,
    COALESCE(r.negative_reviews_count, 0) AS negative_reviews_count,
    COALESCE(r.neutral_reviews_count, 0) AS neutral_reviews_count
FROM googleplaystore a
LEFT JOIN vw_reviews_summary r ON a.app = r.app;

COMMENT ON VIEW view_app_sentiment_summary IS 'View chuẩn tích hợp từ apps và user_reviews phục vụ Notebook 02 và nạp sang Pandas';
