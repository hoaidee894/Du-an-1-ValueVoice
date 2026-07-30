-- ====================================================================
-- DỰ ÁN 1 (AI21301) - NHÓM 1
-- Đề tài: Phân tích ứng dụng Google Play Store
-- Script: 01_create_tables.sql
-- Mô tả: Khởi tạo schema cơ sở dữ liệu (Staging tables, Fact table & Dimension table)
-- Phù hợp với cấu trúc Notebook 02 (02_postgresql_pipeline.ipynb)
-- ====================================================================

-- 1. Xóa các bảng nếu đã tồn tại để tránh xung đột
DROP VIEW IF EXISTS view_app_sentiment_summary CASCADE;
DROP VIEW IF EXISTS vw_googleplaystore_flat CASCADE;
DROP VIEW IF EXISTS vw_reviews_summary CASCADE;
DROP TABLE IF EXISTS user_reviews CASCADE;
DROP TABLE IF EXISTS apps CASCADE;
DROP TABLE IF EXISTS staging_user_reviews CASCADE;
DROP TABLE IF EXISTS staging_apps CASCADE;
DROP TABLE IF EXISTS googleplaystore_user_reviews CASCADE;
DROP TABLE IF EXISTS googleplaystore CASCADE;

-- 2. Tạo bảng tạm (Staging Tables) để chứa dữ liệu thô từ CSV
CREATE TABLE staging_apps (
    app TEXT,
    category TEXT,
    rating TEXT,
    reviews TEXT,
    size TEXT,
    installs TEXT,
    type TEXT,
    price TEXT,
    content_rating TEXT,
    genres TEXT,
    last_updated TEXT,
    current_ver TEXT,
    android_ver TEXT
);

CREATE TABLE staging_user_reviews (
    app TEXT,
    translated_review TEXT,
    sentiment TEXT,
    sentiment_polarity TEXT,
    sentiment_subjectivity TEXT
);

-- Tương thích tên bảng thô cũ
CREATE TABLE googleplaystore (
    app TEXT,
    category VARCHAR(100),
    rating VARCHAR(20),
    reviews VARCHAR(50),
    size VARCHAR(50),
    installs VARCHAR(50),
    type VARCHAR(20),
    price VARCHAR(50),
    content_rating VARCHAR(50),
    genres VARCHAR(100),
    last_updated VARCHAR(50),
    current_ver VARCHAR(100),
    android_ver VARCHAR(100)
);

CREATE TABLE googleplaystore_user_reviews (
    app TEXT,
    translated_review TEXT,
    sentiment VARCHAR(20),
    sentiment_polarity VARCHAR(50),
    sentiment_subjectivity VARCHAR(50)
);

-- 3. Tạo bảng Dimension 'apps' (Bảng danh mục ứng dụng)
CREATE TABLE apps (
    app_id SERIAL PRIMARY KEY,
    app_name TEXT,
    category TEXT,
    rating NUMERIC(4,2),
    reviews INT,
    size TEXT,
    installs TEXT,
    type TEXT,
    price TEXT,
    content_rating TEXT,
    genres TEXT,
    last_updated TEXT,
    current_ver TEXT,
    android_ver TEXT
);

-- 4. Tạo bảng Fact 'user_reviews' (Bảng sự kiện đánh giá cảm nhận người dùng)
CREATE TABLE user_reviews (
    review_id SERIAL PRIMARY KEY,
    app_name TEXT,
    translated_review TEXT,
    sentiment TEXT,
    sentiment_polarity NUMERIC(5,4),
    sentiment_subjectivity NUMERIC(5,4),
    app_id INT REFERENCES apps(app_id) ON DELETE CASCADE
);

COMMENT ON TABLE apps IS 'Bảng Dimension lưu trữ thông tin ứng dụng Google Play Store';
COMMENT ON TABLE user_reviews IS 'Bảng Fact lưu trữ phản hồi và chỉ số cảm xúc của người dùng, liên kết tới apps(app_id)';
