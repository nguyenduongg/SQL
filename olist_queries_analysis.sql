--Tổng doanh thu toàn sàn
SELECT SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset oopd;
-- Các phương thức thanh toán sử dụng nhiều nhất
SELECT payment_type,
		COUNT(order_id) AS total_transactions,
		SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset oopd
GROUP BY payment_type
ORDER BY total_revenue DESC;
-- Top 10 bang có lượng khách hàng lớn nhất
SELECT customer_state, COUNT(customer_id) AS total_customers
FROM olist_customers_dataset ocd 
GROUP BY customer_state 
ORDER BY total_customers DESC
LIMIT 10;
--Khách hàng có tổng chi tiêu cao nhất
SELECT c.customer_unique_id, SUM(p.payment_value) AS total_spent
FROM olist_customers_dataset c 
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p ON o.order_id  = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 5;
--Top 5 sản phẩm bán chạy nhất theo số lượng
SELECT t.product_category_name_english, COUNT(i.order_item_id) AS total_sold
FROM olist_order_items_dataset i
JOIN olist_products_dataset p ON i.product_id = p.product_id 
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english 
ORDER BY total_sold DESC 
LIMIT 5;
--Tỷ lệ các điểm đánh giá từ 1-5 sao
SELECT review_score, COUNT(review_id) AS total_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score DESC;
--Trạng thái hiện tại của các đơn hàng
SELECT order_status,COUNT(order_id) AS total_orders
FROM olist_orders_dataset ood 
GROUP BY order_status 
ORDER BY total_orders DESC;
SELECT 
    STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_month,
    SUM(p.payment_value) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE o.order_status <> 'canceled' -- Loại bỏ các đơn hàng đã bị hủy
GROUP BY order_month
ORDER BY order_month ASC;

