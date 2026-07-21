-- Tạo INDEX cho các cột thường xuyên dùng để tìm kiếm và JOIN/GROUP BY
CREATE INDEX IF NOT EXISTS idx_apps_app_name ON apps(app_name);
CREATE INDEX IF NOT EXISTS idx_apps_category ON apps(category);
