-- ====================================================================
-- DỰ ÁN 1 (AI21301) - NHÓM 1
-- Đề tài: Phân tích ứng dụng Google Play Store
-- Script: 05_indexes.sql
-- Mô tả: Tạo các chỉ mục (INDEX) tối ưu hóa hiệu năng truy vấn WHERE, JOIN và GROUP BY
-- Phù hợp với Notebook 02 (02_postgresql_pipeline.ipynb - Mục IV)
-- ====================================================================

-- 1. Index trên cột app_name của bảng phụ 'apps'
CREATE INDEX IF NOT EXISTS idx_apps_app_name ON apps(app_name);

-- 2. Index trên cột category của bảng phụ 'apps' để tăng tốc lọc và gom nhóm theo Category
CREATE INDEX IF NOT EXISTS idx_apps_category ON apps(category);

-- 3. Index trên cột app_id của bảng chính 'user_reviews' để tối ưu phép JOIN với 'apps'
CREATE INDEX IF NOT EXISTS idx_reviews_app_id ON user_reviews(app_id);

-- 4. Index trên các cột của bảng thô cũ (nếu có truy vấn trực tiếp)
CREATE INDEX IF NOT EXISTS idx_apps_app ON googleplaystore(app);
CREATE INDEX IF NOT EXISTS idx_reviews_app ON googleplaystore_user_reviews(app);
CREATE INDEX IF NOT EXISTS idx_reviews_app_sentiment ON googleplaystore_user_reviews(app, sentiment);
