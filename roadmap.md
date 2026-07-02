# Lộ trình (Roadmap) 18 buổi thực hiện Dự án 1 - Chủ đề Google Play Store Apps

Tài liệu này cung cấp một lộ trình chi tiết, phân chia công việc rõ ràng cho nhóm **4 thành viên** thực hiện dự án phân tích và mô hình hóa dữ liệu ứng dụng Google Play Store.

---

## 1. Phân chia vai trò trong nhóm (4 thành viên)

Để tối ưu hóa hiệu quả làm việc, nhóm được chia làm 4 vai trò cụ thể:

* **Thành viên A (Trưởng nhóm / Data Engineer - DE):**
  * *Nhiệm vụ chính:* Thiết kế schema database, import dữ liệu PostgreSQL, thiết kế PostgreSQL Pipeline, lập trình FastAPI backend, tích hợp API và điều phối tiến độ.
  * *Công cụ:* PostgreSQL, SQL, Python (FastAPI/Uvicorn), Git, Task Tracker.
* **Thành viên B (Data Analyst - DA):**
  * *Nhiệm vụ chính:* Khảo sát dữ liệu thô, thực hiện các truy vấn làm sạch cơ bản và thống kê/aggregation trong SQL, vẽ biểu đồ trực quan hóa dữ liệu (EDA), phân tích các insights kinh doanh/thị trường.
  * *Công cụ:* PostgreSQL, Python (Pandas/Seaborn/Plotly), Jupyter Notebook.
* **Thành viên C (Data Scientist - DS):**
  * *Nhiệm vụ chính:* Xử lý tiền xử lý dữ liệu nâng cao trên Python (missing values, outliers), thực hiện Feature Engineering chuyên sâu (tạo 10 đặc trưng mới), phân tích cảm xúc (Sentiment Analysis) văn bản review, xây dựng và so sánh các mô hình học máy.
  * *Công cụ:* Python (Scikit-learn/Pandas/NLTK/Transformers), Jupyter Notebook.
* **Thành viên D (Web Developer / ML Engineer - MLE):**
  * *Nhiệm vụ chính:* Xây dựng giao diện người dùng Web App (Streamlit), tích hợp mô hình dự đoán, quản lý toàn bộ hệ thống tài liệu báo cáo dự án (Word, Slide PowerPoint) và chuẩn bị kịch bản bảo vệ.
  * *Công cụ:* Streamlit, Python, Microsoft Word/PowerPoint, Markdown.

---

## 2. Lộ trình chi tiết 18 buổi (Chia làm 3 giai đoạn)

### Giai đoạn 1: Data Engineering & Cơ sở dữ liệu (Buổi 1 - Buổi 6)

#### Buổi 1: Khởi động dự án (Kickoff)
* **Mục tiêu:** Thống nhất đề tài, cài đặt môi trường làm việc nhóm.
* **Công việc cụ thể:**
  * *Cả nhóm:* Thống nhất chọn bộ dữ liệu **Google Play Store Apps** (Phần IX). Tạo nhóm trao đổi công việc (Zalo/Discord). Cài đặt môi trường Python (3.14.x) và PostgreSQL cục bộ.
  * *Thành viên A:* Tạo thư mục dự án `Du_AN` trên máy chủ hoặc chia sẻ Drive nhóm, phân chia công việc ban đầu vào file [Task_Tracker.xlsx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/Task_Tracker.xlsx).
  * *Thành viên B & C:* Tải 2 file dữ liệu gốc (`googleplaystore.csv` và `googleplaystore_user_reviews.csv`) vào thư mục `Du_AN/data/raw/`.
  * *Thành viên D:* Khởi tạo file [README.md](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/README.md) mô tả thông tin cơ bản của nhóm và dự án.
* **Sản phẩm:** [Task_Tracker.xlsx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/Task_Tracker.xlsx), [README.md](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/README.md) cập nhật, các thư mục dự án sẵn sàng.

#### Buổi 2: Khảo sát & Đọc hiểu dữ liệu thô (Data Understanding)
* **Mục tiêu:** Hiểu rõ cấu trúc các bảng dữ liệu, số cột, kiểu dữ liệu thực tế và các lỗi dữ liệu.
* **Công việc cụ thể:**
  * *Thành viên B (Chủ trì) & C:* Viết code trong [01_data_understanding.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/01_data_understanding.ipynb) để:
    * Đọc 2 file CSV gốc.
    * Xem thông tin `.info()`, `.describe()`, kiểm tra tỷ lệ giá trị thiếu (Missing values), các giá trị trùng lặp (Duplicates).
    * Phát hiện các vấn đề định dạng (ví dụ: cột `Installs` chứa ký tự `+` và `,`, cột `Price` chứa `$`, cột `Size` chứa `M` hoặc `k`).
  * *Thành viên A:* Hỗ trợ chuẩn bị schema SQL ban đầu dựa trên kiểu dữ liệu đề xuất từ Thành viên B.
  * *Thành viên D:* Cập nhật tài liệu kỹ thuật về mô tả các cột dữ liệu vào folder `docs/`.
* **Sản phẩm:** Code khảo sát trong [01_data_understanding.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/01_data_understanding.ipynb).

#### Buổi 3: Thiết kế Schema & Import dữ liệu PostgreSQL
* **Mục tiêu:** Đưa dữ liệu thành công vào hệ quản trị cơ sở dữ liệu để phục vụ xử lý lớn.
* **Công việc cụ thể:**
  * *Thành viên A (Chủ trì):* Thiết lập cơ sở dữ liệu trên PostgreSQL. Viết file [01_create_tables.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/01_create_tables.sql) để định nghĩa cấu trúc bảng (chú ý chọn kiểu dữ liệu phù hợp, tạm thời để các cột có lỗi định dạng là `VARCHAR` để import).
  * *Thành viên B:* Viết script import dữ liệu [02_import_data.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/02_import_data.sql) sử dụng lệnh `COPY` hoặc `\copy` trong PostgreSQL.
  * *Thành viên C & D:* Chạy thử nghiệm việc import trên máy cá nhân, ghi nhận các lỗi phát sinh (ví dụ dòng bị lệch cột) và phối hợp với Thành viên A để sửa lỗi.
* **Sản phẩm:** File SQL [01_create_tables.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/01_create_tables.sql) và [02_import_data.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/02_import_data.sql).

#### Buổi 4: Làm sạch dữ liệu & Xây dựng DB Pipeline
* **Mục tiêu:** Sử dụng SQL để chuẩn hóa định dạng dữ liệu, loại bỏ nhiễu và lưu trữ bản sạch vào database.
* **Công việc cụ thể:**
  * *Thành viên B (Chủ trì) & A:* Viết file [03_views.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/03_views.sql) và tích hợp vào [02_postgresql_pipeline.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/02_postgresql_pipeline.ipynb):
    * Loại bỏ trùng lặp ứng dụng (chỉ giữ lại dòng có số `Reviews` lớn nhất cho mỗi `App`).
    * Làm sạch cột: Chuyển `Installs` (bỏ `+`, `,` thành kiểu INT), `Price` (bỏ `$` thành DECIMAL), `Size` (chuẩn hóa về cùng đơn vị MB dưới dạng số), `Last Updated` (đưa về định dạng DATE).
    * Thực hiện `LEFT JOIN` bảng apps và bảng reviews thông qua cột `App` để tạo một View tổng hợp.
  * *Thành viên C:* Kiểm tra chất lượng dữ liệu sau làm sạch (data profiling) bằng python.
  * *Thành viên D:* Viết nhật ký tiến độ làm sạch vào báo cáo.
* **Sản phẩm:** View sạch trong Database, script trong [03_views.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/03_views.sql) và [02_postgresql_pipeline.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/02_postgresql_pipeline.ipynb).

#### Buổi 5: Truy vấn tổng hợp (Aggregation) & Tối ưu hóa Database
* **Mục tiêu:** Rút ra các thống kê kinh doanh quan trọng và tối ưu hóa tốc độ truy vấn cơ sở dữ liệu.
* **Công việc cụ thể:**
  * *Thành viên B (Chủ trì):* Viết script [04_aggregation.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/04_aggregation.sql) thực hiện các thống kê:
    * Số lượng ứng dụng, tổng số lượt tải, rating trung bình theo từng nhóm `Category`.
    * Phân tích tỷ lệ ứng dụng Miễn phí (Free) vs Trả phí (Paid) và mức giá trung bình của từng ngành hàng.
    * Thống kê số lượng review tích cực/tiêu cực trung bình theo ứng dụng.
  * *Thành viên A:* Viết file [05_indexes.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/05_indexes.sql) tạo các chỉ mục (INDEX) trên cột `App` và `Category` để tăng tốc độ JOIN và truy vấn.
  * *Thành viên C & D:* Xuất kết quả các câu lệnh aggregation ra các file CSV tạm thời để chuẩn bị trực quan hóa.
* **Sản phẩm:** Các file [04_aggregation.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/04_aggregation.sql) và [05_indexes.sql](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/sql/05_indexes.sql).

#### Buổi 6: Đánh giá Giai đoạn 1 & Xuất dữ liệu sạch sang Python
* **Mục tiêu:** Hoàn tất giai đoạn Data Engineering, sẵn sàng bộ dữ liệu sạch cho phân tích nâng cao.
* **Công việc cụ thể:**
  * *Thành viên A (Chủ trì):* Viết mã kết nối SQLAlchemy trong Python để xuất toàn bộ bảng dữ liệu đã sạch từ PostgreSQL thành tệp tin `cleaned_data.csv` (lưu trữ tạm ở local hoặc `data/processed/` phục vụ nghiên cứu).
  * *Thành viên B & C:* Xác thực dữ liệu sau khi xuất xem có bị lỗi font chữ tiếng Việt hay mất mát thông tin không.
  * *Thành viên D:* Cập nhật bảng phân công công việc giai đoạn tiếp theo vào [Task_Tracker.xlsx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/Task_Tracker.xlsx).
* **Sản phẩm:** Dữ liệu sạch ban đầu sẵn sàng phục vụ cho phân tích trong Python.

---

### Giai đoạn 2: Data Science, EDA & Học máy (Buổi 7 - Buổi 12)

#### Buổi 7: Tiền xử lý nâng cao bằng Python (Python Cleaning)
* **Mục tiêu:** Xử lý triệt để các vấn đề phức tạp như Outliers và Missing values nâng cao.
* **Công việc cụ thể:**
  * *Thành viên C (Chủ trì):* Viết code trong [03_data_cleaning.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/03_data_cleaning.ipynb):
    * Điền khuyết thiếu cho cột `Rating` bằng các phương pháp nâng cao (như KNN Imputation hoặc điền bằng Median của nhóm `Category` tương ứng).
    * Phát hiện nhiễu (outliers) ở cột `Reviews` và `Price` bằng phương pháp IQR (Interquartile Range) hoặc Z-score.
  * *Thành viên B:* Hỗ trợ DS trực quan hóa phân phối dữ liệu trước và sau khi làm sạch để kiểm tra độ lệch (skewness).
  * *Thành viên A & D:* Chuẩn hóa môi trường làm việc python, cập nhật các gói thư viện vào file [requirements.txt](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/requirements.txt) nếu phát sinh thư viện mới.
* **Sản phẩm:** Mã nguồn làm sạch chi tiết tại [03_data_cleaning.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/03_data_cleaning.ipynb).

#### Buổi 8: Phân tích khám phá dữ liệu trực quan (EDA & Visualization)
* **Mục tiêu:** Vẽ biểu đồ khám phá sâu mối quan hệ giữa các biến số và trích xuất insights hữu ích.
* **Công việc cụ thể:**
  * *Thành viên B (Chủ trì) & C:* Làm việc trên [04_eda_visualization.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/04_eda_visualization.ipynb):
    * Trực quan hóa phân bố Rating của các Category bằng Boxplot/Violin plot.
    * Biểu đồ Scatter thể hiện mối quan hệ giữa kích thước App (`Size`) và số lượng cài đặt (`Installs`).
    * Biểu đồ heatmap thể hiện độ tương quan (Correlation Matrix) giữa các biến số.
    * Phân tích sự ảnh hưởng của mức giá (`Price`) đến đánh giá từ người dùng (`Rating`).
  * *Thành viên A:* Hỗ trợ trích xuất nhanh các dữ liệu phụ trợ từ Database nếu cần.
  * *Thành viên D:* Lưu trữ các hình vẽ biểu đồ chất lượng cao vào thư mục `reports/images/` để chuẩn bị viết slide.
* **Sản phẩm:** Các biểu đồ phân tích sâu trong [04_eda_visualization.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/04_eda_visualization.ipynb) và kho ảnh lưu tại `reports/images/`.

#### Buổi 9: Phân tích cảm xúc văn bản (Reviews Sentiment Analysis)
* **Mục tiêu:** Khai phá dữ liệu văn bản review từ người dùng và tính toán điểm cảm xúc của từng ứng dụng.
* **Công việc cụ thể:**
  * *Thành viên C (Chủ trì):* Viết code xử lý NLP trong notebook [05_feature_engineering.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/05_feature_engineering.ipynb):
    * Tiền xử lý văn bản ở cột `Translated_Review` (loại bỏ ký tự đặc biệt, đưa về chữ thường).
    * Thống kê tỷ lệ Positive, Negative, Neutral của từng ứng dụng.
    * Tính điểm trung bình của `Sentiment_Polarity` (độ tích cực) và `Sentiment_Subjectivity` (độ khách quan) cho mỗi ứng dụng.
  * *Thành viên B:* Trực quan hóa biểu đồ mây từ (Word Cloud) cho các review tích cực và tiêu cực để tìm lý do app bị gỡ cài đặt hoặc được khen ngợi.
  * *Thành viên A & D:* Thiết kế bảng trung gian để lưu thông tin Sentiment tổng hợp của từng app và cập nhật database.
* **Sản phẩm:** Code xử lý NLP và điểm Sentiment tổng hợp của các ứng dụng tích hợp vào luồng dữ liệu.

#### Buổi 10: Kỹ nghệ đặc trưng (Feature Engineering - Tạo 10 đặc trưng mới)
* **Mục tiêu:** Tạo ra tối thiểu 10 đặc trưng mới giúp nâng cao hiệu quả dự đoán của mô hình học máy.
* **Công việc cụ thể:**
  * *Thành viên C (Chủ trì) & B:* Viết mã nguồn trong [05_feature_engineering.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/05_feature_engineering.ipynb) tạo ra 10 biến mới, gợi ý:
    1. `Is_Paid`: Biến nhị phân phân loại ứng dụng Trả phí/Miễn phí.
    2. `Price_Tier`: Phân nhóm giá ứng dụng (Rẻ, Trung bình, Đắt).
    3. `Install_Tier`: Phân nhóm lượt cài đặt (Phổ biến, Vừa, Ít phổ biến).
    4. `Days_Since_Last_Update`: Số ngày tính từ lần cập nhật cuối cùng tới mốc thời gian phân tích.
    5. `Is_New_App`: Ứng dụng mới cập nhật gần đây (ví dụ dưới 180 ngày).
    6. `Avg_Sentiment_Polarity`: Điểm cảm xúc trung bình của khách hàng.
    7. `Sentiment_Ratio`: Tỷ lệ review tích cực / tổng số review.
    8. `App_Name_Length`: Độ dài của tên ứng dụng (giả thuyết tên ngắn dễ nhớ hơn).
    9. `Size_Per_Install`: Tỷ lệ kích thước ứng dụng trên lượt tải.
    10. `Genre_Count`: Số lượng thể loại phụ mà ứng dụng thuộc về.
  * *Thành viên A:* Hỗ trợ ghi nhận các đặc trưng này và xuất ra file dữ liệu đã qua xử lý (`train.csv`, `test.csv`) lưu tại `data/processed/`.
  * *Thành viên D:* Viết thuyết minh ý nghĩa nghiệp vụ của 10 đặc trưng này vào báo cáo dự án.
* **Sản phẩm:** Tệp tin dữ liệu huấn luyện `train.csv`, `test.csv` và code tạo đặc trưng hoàn chỉnh.

#### Buổi 11: Huấn luyện các mô hình Machine Learning ban đầu
* **Mục tiêu:** Phân tách tập dữ liệu và chạy thử nghiệm nhiều thuật toán học máy khác nhau.
* **Công việc cụ thể:**
  * *Thành viên C (Chủ trì):* Viết code trong [06_machine_learning.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/06_machine_learning.ipynb):
    * Thực hiện mã hóa các biến phân loại (One-Hot Encoding, Label Encoding).
    * Chuẩn hóa thang đo dữ liệu (Scaling) bằng `StandardScaler` hoặc `MinMaxScaler`.
    * Chia tập dữ liệu Train/Test (tỷ lệ 80/20 hoặc 70/30).
    * Huấn luyện các mô hình dự đoán (ví dụ: dự đoán điểm `Rating` bằng các mô hình hồi quy: *Linear Regression*, *Decision Tree*, *Random Forest*, *XGBoost* hoặc *LightGBM*).
  * *Thành viên B:* Hỗ trợ đánh giá các metric ban đầu (R2-score, RMSE, MAE).
  * *Thành viên A & D:* Chuẩn bị các cấu trúc lưu trữ mô hình và scaler.
* **Sản phẩm:** Các mô hình học máy cơ bản đã được huấn luyện thành công.

#### Buổi 12: Tối ưu hóa & Đóng gói mô hình tốt nhất
* **Mục tiêu:** Tinh chỉnh siêu tham số và đóng gói mô hình tốt nhất phục vụ cho việc deploy sản phẩm.
* **Công việc cụ thể:**
  * *Thành viên C (Chủ trì):* Thực hiện Hyperparameter tuning (bằng GridSearchC hoặc RandomizedSearchCV) để tìm bộ tham số tối ưu cho mô hình xuất sắc nhất.
  * *Thành viên A & C:* Đóng gói mô hình học máy đã tối ưu và scaler thành các file nhị phân:
    * `models/model.pkl`
    * `models/scaler.pkl`
  * *Thành viên B:* Vẽ biểu đồ so sánh độ chính xác giữa các thuật toán và biểu đồ mức độ quan trọng của các đặc trưng (Feature Importance).
  * *Thành viên D:* Chụp lại các biểu đồ đánh giá chất lượng mô hình để chèn vào tài liệu kỹ thuật.
* **Sản phẩm:** Tệp tin mô hình hoàn chỉnh [model.pkl](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/models/model.pkl) và [scaler.pkl](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/models/scaler.pkl).

---

### Giai đoạn 3: Phát triển sản phẩm, Báo cáo & Bảo vệ (Buổi 13 - Buổi 18)

#### Buổi 13: Xây dựng Backend API (FastAPI)
* **Mục tiêu:** Tạo các API endpoint nhận thông tin ứng dụng đầu vào và trả về dự đoán (Rating/Số lượt tải).
* **Công việc cụ thể:**
  * *Thành viên A (Chủ trì):* Viết file [api.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/api.py):
    * Khởi tạo ứng dụng FastAPI.
    * Tạo endpoint POST `/predict` nhận thông tin JSON chứa thông tin ứng dụng (Category, Size, Type, Price, Sentiment, v.v.).
  * *Thành viên C:* Viết file logic dự đoán [prediction.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/prediction.py) thực hiện việc load mô hình `model.pkl` và `scaler.pkl`, nhận tham số, tiền xử lý nhanh dữ liệu đầu vào và trả về điểm số dự đoán.
  * *Thành viên B & D:* Kiểm thử hoạt động của API bằng Swagger UI (`http://127.0.0.1:8000/docs`).
* **Sản phẩm:** Backend API hoạt động trơn tru tại [api.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/api.py) và [prediction.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/prediction.py).

#### Buổi 14: Xây dựng Giao diện Web App (Streamlit)
* **Mục tiêu:** Tạo giao diện đồ họa thân thiện để người dùng nhập thông số và xem dự đoán trực tiếp.
* **Công việc cụ thể:**
  * *Thành viên D (Chủ trì):* Thiết kế và viết code giao diện trong [streamlit_app.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/streamlit_app.py):
    * Tạo các input control (Dropdown chọn Category, slider chọn Size, input nhập Price, text box viết review thử nghiệm).
    * Tạo nút "Dự đoán" để gọi sang FastAPI và hiển thị kết quả trực quan (kết hợp các thông số biểu đồ nhỏ).
  * *Thành viên B:* Thiết kế thêm các trang phụ (nằm trong thư mục `app/pages/`) để hiển thị báo cáo EDA trực tiếp trên giao diện Streamlit.
  * *Thành viên A & C:* Hỗ trợ tích hợp và xử lý dữ liệu truyền tải giữa giao diện và backend.
* **Sản phẩm:** Giao diện giao tiếp người dùng hoàn thành tại [streamlit_app.py](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/app/streamlit_app.py).

#### Buổi 15: Kiểm thử liên thông hệ thống (Integration Testing)
* **Mục tiêu:** Kết nối hoàn tất Streamlit với FastAPI, sửa lỗi luồng dữ liệu (End-to-End).
* **Công việc cụ thể:**
  * *Thành viên A (Chủ trì) & D:* Thực hiện kết nối: Khi người dùng bấm nút trên Streamlit -> Streamlit gửi request đến FastAPI API -> API tính toán dự đoán và trả về -> Streamlit hiển thị.
  * *Thành viên C:* Viết các hàm tiện ích bổ trợ trong thư mục `app/utils/` để format kết quả, xử lý ngoại lệ khi người dùng nhập sai dữ liệu.
  * *Thành viên B:* Viết file thử nghiệm tích hợp [07_prediction_demo.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/07_prediction_demo.ipynb) để minh họa một luồng chạy mẫu của ứng dụng từ lúc nạp dữ liệu tới lúc ra dự đoán.
* **Sản phẩm:** Hệ thống demo chạy ổn định không lỗi, file [07_prediction_demo.ipynb](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/notebooks/07_prediction_demo.ipynb) hoàn tất.

#### Buổi 16: Hoàn thiện Báo cáo Dự án (Word Document)
* **Mục tiêu:** Tổng hợp toàn bộ lý thuyết, quá trình làm việc, insights và mô hình thành một báo cáo hoàn chỉnh.
* **Công việc cụ thể:**
  * *Thành viên D (Chủ trì):* Cập nhật nội dung chi tiết từ file mẫu vào file báo cáo chính thức [tai-lieu-du-an-nhom-1.docx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/reports/tai-lieu-du-an-nhom-1.docx).
  * *Thành viên B:* Biên soạn phần nội dung mô tả dữ liệu, các biểu đồ trực quan hóa dữ liệu (EDA) kèm theo lý giải nghiệp vụ.
  * *Thành viên C:* Biên soạn phần Kỹ nghệ đặc trưng, giải thích mô hình Machine Learning sử dụng, bảng so sánh hiệu năng các thuật toán.
  * *Thành viên A:* Viết mô tả phần thiết kế Database PostgreSQL và sơ đồ kiến trúc ứng dụng web.
* **Sản phẩm:** Tài liệu báo cáo hoàn chỉnh [tai-lieu-du-an-nhom-1.docx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/reports/tai-lieu-du-an-nhom-1.docx) sẵn sàng để nộp.

#### Buổi 17: Thiết kế Slide thuyết trình & Chuẩn bị Demo
* **Mục tiêu:** Tạo slide thuyết trình chuyên nghiệp, tóm lược được toàn bộ giá trị của dự án trong 15-20 phút bảo vệ.
* **Công việc cụ thể:**
  * *Thành viên D (Chủ trì):* Biên soạn slide dựa trên file PowerPoint mẫu tại [slide-du-an-nhom-1.pptx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/reports/slide-du-an-nhom-1.pptx).
  * *Thành viên B & C:* Chọn lọc các hình ảnh biểu đồ EDA đắt giá nhất và bảng so sánh mô hình đưa vào slide.
  * *Thành viên A:* Chuẩn bị sẵn dữ liệu mẫu trong thư mục `data/sample/` để chạy demo trực tiếp không gặp sự cố về mạng.
  * *Cả nhóm:* Phân chia phần thuyết trình cho từng thành viên: Thành viên A (Giới thiệu + Hệ thống/DB), Thành viên B (EDA/Insights), Thành viên C (Học máy/NLP), Thành viên D (Demo Web + Kết luận).
* **Sản phẩm:** Slide hoàn thiện tại [slide-du-an-nhom-1.pptx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/reports/slide-du-an-nhom-1.pptx).

#### Buổi 18: Đóng gói dự án & Tổng duyệt (Dry Run)
* **Mục tiêu:** Chạy thử nghiệm thuyết trình, tối ưu hóa code và dọn dẹp thư mục trước khi chấm điểm.
* **Công việc cụ thể:**
  * *Cả nhóm:* Thực hiện thuyết trình thử, canh thời gian bảo vệ, chuẩn bị các câu hỏi phản biện từ giáo viên hướng dẫn.
  * *Thành viên A:* Viết hướng dẫn chi tiết cách khởi động ứng dụng FastAPI và Streamlit vào file [README.md](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/README.md).
  * *Thành viên D:* Cập nhật trạng thái tất cả các đầu việc thành "Completed" trong [Task_Tracker.xlsx](file:///c:/HOC_HANH/Mon%20dang%20hoc/AI21301_DU_AN_1/Du_AN/Task_Tracker.xlsx).
* **Sản phẩm:** Dự án hoàn thiện 100%, sẵn sàng báo cáo trước hội đồng chấm điểm môn Dự án 1.

---

## 3. Bản đồ tiến độ theo tuần (Gợi ý phân bổ thời gian)

```mermaid
gantt
    title Kế hoạch Tiến độ Dự án 1 - Nhóm 4 Thành viên
    dateFormat  D
    axisFormat Buổi %e
    
    section Giai đoạn 1: Data Engineering
    Thiết lập & Khảo sát dữ liệu thô       :active, 1, 2
    Cơ sở dữ liệu & Import PostgreSQL      : 3, 3
    Làm sạch dữ liệu & DB Pipeline        : 4, 4
    Truy vấn tổng hợp & Index             : 5, 5
    Đánh giá GĐ 1 & Xuất dữ liệu          : 6, 6
    
    section Giai đoạn 2: Data Science & ML
    Làm sạch nâng cao bằng Python          : 7, 7
    Trực quan hóa dữ liệu (EDA)           : 8, 8
    Phân tích cảm xúc reviews (NLP)       : 9, 9
    Tạo 10 đặc trưng mới (Feature Eng)    : 10, 10
    Huấn luyện & Đóng gói mô hình ML      : 11, 12
    
    section Giai đoạn 3: Productization & Báo cáo
    Phát triển Backend API (FastAPI)      : 13, 13
    Xây dựng giao diện Streamlit Web App   : 14, 15
    Viết tài liệu báo cáo dự án (Word)    : 16, 16
    Thiết kế Slide PPT & Chuẩn bị Demo     : 17, 17
    Tổng duyệt & Đóng gói dự án           : 18, 18
```
