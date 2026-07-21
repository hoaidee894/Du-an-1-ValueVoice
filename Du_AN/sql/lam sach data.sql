-- 1. Làm sạch cột Installs (Xóa dấu '+' và dấu ',', chuyển về kiểu INT)
UPDATE apps
SET installs = REGEXP_REPLACE(installs, '[+,]', '', 'g')
WHERE installs ~ '[+,]';

-- 2. Làm sạch cột Price (Xóa ký hiệu '$', nếu là '0' hoặc trống thì để là 0, chuyển về số thực)
UPDATE apps
SET price = REGEXP_REPLACE(price, '[\$]', '', 'g')
WHERE price ~ '[\$]';

-- 3. Đồng bộ các giá trị trống hoặc 'NaN' về NULL để chuẩn hóa
UPDATE apps
SET 
    rating = CASE WHEN rating IS NULL THEN NULL ELSE rating END,
    size = CASE WHEN size = 'Varies with device' OR size = 'nan' THEN NULL ELSE size END;