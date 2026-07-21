-- SQL Script placeholder
CREATE OR REPLACE VIEW view_app_sentiment_summary AS
SELECT 
    a.app_id,
    a.app_name,
    a.category,
    a.rating,
    a.reviews,
    a.installs,
    COUNT(r.review_id) AS total_reviews_analyzed,
    SUM(CASE WHEN r.sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_reviews,
    SUM(CASE WHEN r.sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_reviews
FROM apps a
LEFT JOIN user_reviews r ON a.app_id = r.app_id
GROUP BY a.app_id, a.app_name, a.category, a.rating, a.reviews, a.installs;
