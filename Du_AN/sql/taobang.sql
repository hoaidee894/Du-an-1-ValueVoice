-- =========================================================================
-- BƯỚC 1: XÓA VÀ TẠO MỚI CÁC BẢNG CHÍNH THỨC (ĐÃ TỐI ƯU CỘT ĐỂ TRÁNH TRÀN DATA)
-- =========================================================================
DROP TABLE IF EXISTS user_reviews CASCADE;
DROP TABLE IF EXISTS apps CASCADE;

CREATE TABLE apps (
    app_id SERIAL PRIMARY KEY,
    app_name TEXT,
    category TEXT,
    rating NUMERIC(4,2), -- Tăng lên 4,2 để nuốt trọn điểm mà không lo lỗi numeric overflow
    reviews INT,
    size TEXT,
    installs TEXT,
    type TEXT,           -- Để TEXT luôn cho an toàn, không lo giới hạn VARCHAR(10)
    price TEXT,          -- Để TEXT luôn cho an toàn
    content_rating TEXT,
    genres TEXT,
    last_updated TEXT,
    current_ver TEXT,
    android_ver TEXT
);

CREATE TABLE user_reviews (
    review_id SERIAL PRIMARY KEY,
    app_name TEXT,
    translated_review TEXT,
    sentiment TEXT,
    sentiment_polarity NUMERIC(5,4),
    sentiment_subjectivity NUMERIC(5,4),
    app_id INT REFERENCES apps(app_id) ON DELETE CASCADE
);

-- =========================================================================
-- BƯỚC 2: XÓA VÀ TẠO BẢNG TẠM CHỈ CÓ 1 CỘT (ĐỂ KHÔNG BỊ LỆCH CỘT DÒNG 10474)
-- =========================================================================
DROP TABLE IF EXISTS staging_raw_line CASCADE;
DROP TABLE IF EXISTS staging_user_reviews CASCADE;
DROP TABLE IF EXISTS staging_googleplaystore CASCADE;

CREATE TABLE staging_raw_line (
    raw_content TEXT
);

CREATE TABLE staging_user_reviews (
    app TEXT, translated_review TEXT, sentiment TEXT,
    sentiment_polarity TEXT, sentiment_subjectivity TEXT
);

-- =========================================================================
-- BƯỚC 3: COPY DỮ LIỆU THÔ TỪ Ổ C VÀO BẢNG TẠM
-- =========================================================================

-- 1. Nạp tệp Apps dưới dạng các dòng text thuần túy (vượt qua mọi lỗi cấu trúc file)
COPY staging_raw_line FROM 'C:/googleplaystore.csv' WITH (FORMAT text);

-- 2. Nạp tệp User Reviews vào bảng tạm
COPY staging_user_reviews FROM 'C:/googleplaystore_user_reviews.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 3. Bóc tách text từ bảng tạm thành các cột dữ liệu tương ứng
CREATE TABLE staging_googleplaystore AS 
SELECT 
    (split_part(raw_content, ',', 1)) as app,
    (split_part(raw_content, ',', 2)) as category,
    (split_part(raw_content, ',', 3)) as rating,
    (split_part(raw_content, ',', 4)) as reviews,
    (split_part(raw_content, ',', 5)) as size,
    (split_part(raw_content, ',', 6)) as installs,
    (split_part(raw_content, ',', 7)) as type,
    (split_part(raw_content, ',', 8)) as price,
    (split_part(raw_content, ',', 9)) as content_rating,
    (split_part(raw_content, ',', 10)) as genres,
    (split_part(raw_content, ',', 11)) as last_updated,
    (split_part(raw_content, ',', 12)) as current_ver,
    (split_part(raw_content, ',', 13)) as android_ver
FROM staging_raw_line
OFFSET 1; -- Bỏ qua dòng tiêu đề

-- =========================================================================
-- BƯỚC 4: LÀM SẠCH VÀ ĐẨY CHÍNH THỨC VÀO CƠ SỞ DỮ LIỆU
-- =========================================================================

-- 4.1. Đổ dữ liệu sạch vào bảng 'apps'
INSERT INTO apps (app_name, category, rating, reviews, size, installs, type, price, content_rating, genres, last_updated, current_ver, android_ver)
SELECT DISTINCT ON (app)
    app, category,
    CASE WHEN rating ~ '^[0-9.]+$' THEN CAST(rating AS NUMERIC(4,2)) ELSE NULL END,
    CASE WHEN reviews ~ '^[0-9]+$' THEN CAST(reviews AS INT) ELSE 0 END,
    size, installs, type, price, content_rating, genres, last_updated, current_ver, android_ver
FROM staging_googleplaystore
WHERE installs <> 'Free' AND installs <> '' AND app IS NOT NULL AND app <> ''
ORDER BY app;

-- 4.2. Đổ dữ liệu sạch vào bảng 'user_reviews' và tự động ánh xạ app_id sang bảng apps
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

-- =========================================================================
-- BƯỚC 5: XÓA RÁC (BẢNG TẠM) & TỐI ƯU HỆ THỐNG
-- =========================================================================
DROP TABLE IF EXISTS staging_raw_line;
DROP TABLE IF EXISTS staging_googleplaystore;
DROP TABLE IF EXISTS staging_user_reviews;

ANALYZE apps;
ANALYZE user_reviews;