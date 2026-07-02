# Dự án phân tích ứng dụng Google Play Store

Dự án này thực hiện phân tích và mô hình hóa dữ liệu Google Play Store để tìm hiểu các yếu tố ảnh hưởng tới chất lượng và mức độ phổ biến của các ứng dụng, kết hợp phân tích cảm xúc từ đánh giá của người dùng.

## Cấu trúc thư mục dự án

```
Du_AN/
├── data/                         
│   ├── raw/                      # các file CSV gốc
│   ├── processed/                # dữ liệu sau xử lý: train.csv, test.csv
│   └── sample/                   # dữ liệu mẫu để demo
├── docs/                         # các file tài liệu cho dự án
├── notebooks/                    # các file notebooks
│   ├── 01_data_understanding.ipynb
│   ├── 02_postgresql_pipeline.ipynb
│   ├── 03_data_cleaning.ipynb
│   ├── 04_eda_visualization.ipynb
│   ├── 05_feature_engineering.ipynb
│   ├── 06_machine_learning.ipynb
│   └── 07_prediction_demo.ipynb
├── sql/                          # các SQL (tạo bảng, view, import data)
│   ├── 01_create_tables.sql
│   ├── 02_import_data.sql
│   ├── 03_views.sql
│   ├── 04_aggregation.sql
│   └── 05_indexes.sql
├── prompts/                      # các file prompts
├── app/                          # Code ứng dụng web (Streamlit + FastAPI)
│   ├── streamlit_app.py
│   ├── api.py
│   ├── utils/
│   ├── pages/
│   └── prediction.py
├── models/                       # File mô hình đã train (.pkl)
│   ├── model.pkl
│   └── scaler.pkl
├── reports/                      # Báo cáo Word, PPTX và hình ảnh
│   ├── tai-lieu-du-an-nhom-1.docx
│   ├── slide-du-an-nhom-1.pptx
│   └── images/
├── README.md                     # Hướng dẫn chi tiết chạy dự án, cấu hình, cài đặt
├── Task_Tracker.xlsx             # Phân công, theo dõi công việc
└── requirements.txt              # Danh sách thư viện
```

## Các thư viện chính được sử dụng
Cài đặt các thư viện cần thiết thông qua file `requirements.txt`:
```bash
pip install -r requirements.txt
```
