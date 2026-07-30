-- ====================================================================
-- DỰ ÁN 1 (AI21301) - NHÓM 1
-- Đề tài: Phân tích ứng dụng Google Play Store
-- Script: 02_import_data.sql
-- Mô tả: Thao tác import dữ liệu từ CSV vào Staging và chuyển đổi sang các bảng Relational ('apps', 'user_reviews')
-- Phù hợp với Notebook 02 (02_postgresql_pipeline.ipynb)
-- ====================================================================

-- 1. Import dữ liệu thô từ CSV vào Staging tables
-- (Có thể chạy trực tiếp bằng psql CLI hoặc pgAdmin Query Tool)

-- COPY staging_apps FROM 'c:/HOC_HANH/Mon dang hoc/AI21301_DU_AN_1/Du_AN/data/raw/googleplaystore.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
-- COPY staging_user_reviews FROM 'c:/HOC_HANH/Mon dang hoc/AI21301_DU_AN_1/Du_AN/data/raw/googleplaystore_user_reviews.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');

-- COPY googleplaystore FROM 'c:/HOC_HANH/Mon dang hoc/AI21301_DU_AN_1/Du_AN/data/raw/googleplaystore.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
-- COPY googleplaystore_user_reviews FROM 'c:/HOC_HANH/Mon dang hoc/AI21301_DU_AN_1/Du_AN/data/raw/googleplaystore_user_reviews.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');

-- 2. Chuyển đổi và nạp dữ liệu từ Staging vào Bảng phụ / Dimension 'apps'
INSERT INTO apps (app_name, category, rating, reviews, size, installs, type, price, content_rating, genres, last_updated, current_ver, android_ver)
SELECT DISTINCT ON (app)
    app, category,
    CASE WHEN rating ~ '^[0-9.]+$' THEN CAST(rating AS NUMERIC(4,2)) ELSE NULL END,
    CASE WHEN reviews ~ '^[0-9]+$' THEN CAST(reviews AS INT) ELSE 0 END,
    size, installs, type, price, content_rating, genres, last_updated, current_ver, android_ver
FROM staging_apps
WHERE installs <> 'Free' AND installs <> '' AND app IS NOT NULL AND app <> ''
ORDER BY app;

-- 3. Chuyển đổi và nạp dữ liệu vào Bảng chính / Fact 'user_reviews' với ánh xạ khóa ngoại app_id
INSERT INTO user_reviews (app_name, translated_review, sentiment, sentiment_polarity, sentiment_subjectivity, app_id)
SELECT 
    r.app,
    CASE WHEN r.translated_review = 'nan' THEN NULL ELSE r.translated_review END,
    CASE WHEN r.sentiment = 'nan' THEN NULL ELSE r.sentiment END,
    CASE WHEN r.sentiment_polarity ~ '^-?[0-9.]+$' THEN CAST(r.sentiment_polarity AS NUMERIC(5,4)) ELSE NULL END,
    CASE WHEN r.sentiment_subjectivity ~ '^-?[0-9.]+$' THEN CAST(r.sentiment_subjectivity AS NUMERIC(5,4)) ELSE NULL END,
    a.app_id 
FROM staging_user_reviews r
INNER JOIN apps a ON r.app = a.app_name 
WHERE r.app IS NOT NULL AND r.app <> '';

-- 4. Kiểm tra số lượng dòng sau khi import thành công
SELECT 'apps' AS table_name, COUNT(*) AS row_count FROM apps
UNION ALL
SELECT 'user_reviews' AS table_name, COUNT(*) AS row_count FROM user_reviews;
