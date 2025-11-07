# 🍕 Swiggy Root Cause Analysis (RCA) Project — SQL + Python + Power BI

This project investigates a **6.5% drop in Swiggy orders between Jan–Feb 2024**, performing an end-to-end Root Cause Analysis (RCA) using **SQL, Python, and Power BI**.  
It identifies the main reasons behind the decline — including **repeat customer inactivity** and **delivery cancellations** — and provides actionable insights to improve performance.

---

## 🚀 **Project Overview**

Food delivery platforms like Swiggy depend heavily on consistent order growth and customer retention.  
When a month-over-month decline occurs, understanding *why* becomes crucial.

This project performs a **Root Cause Analysis (RCA)** using:
- **SQL** — to extract and combine multi-table relational data  
- **Python** — for EDA, data cleaning, and visualization  
- **Power BI** — for interactive dashboards and KPI reporting  

The final outcome highlights the root causes behind order decline and suggests business strategies for improvement.

---

## ⚙️ **Tech Stack**

| Component | Description |
|------------|-------------|
| **Languages** | SQL, Python |
| **Libraries (Python)** | pandas, matplotlib, seaborn, sqlalchemy |
| **Visualization Tool** | Power BI |
| **Database** | MySQL |
| **Dataset Source** | [Swiggy 2023–2024 Dataset (Kaggle)](https://www.kaggle.com/datasets/ishitahra/swiggy2324) |
| **Tables Used** | customer_data, orders_data, restaurant_data, deliverytx_data, order_item_data, location_data, menu_data, order_address_data |
| **Analysis Type** | Root Cause Analysis (RCA), Funnel Analysis, Performance Trend Analysis |

---

## 🧠 **Key Insights**

✅ Detected a **6.5% drop in total orders** between Jan → Feb 2024  
✅ Decline primarily among **repeat customers**  
✅ Spike in **delivery cancellations** and **delays**  
✅ Notable performance drop among key restaurants in metro areas  
✅ Suggested data-driven improvements in **retention, delivery, and UX**

---

## 🧩 **Project Workflow**

1. **Data Integration**
   - Loaded and joined 8+ relational tables using SQL views.  
   - Created analytical datasets for orders, customers, and deliveries.

2. **Trend & RCA Analysis**
   - Compared order patterns for 2023 vs 2024.  
   - Focused on **Jan–Feb 2024** drop.  
   - Analyzed delivery failures, customer churn, and restaurant performance.

3. **Visualization**
   - Python visualizations for trend and funnel analysis. 

4. **Actionable Recommendations**
   - Loyalty programs for repeat customers  
   - Delivery route optimization  
   - Partner performance tracking  
   - UX improvements to streamline reordering and payment flow  

---

## 📊 **Sample Results**

| Metric | Jan 2024 | Feb 2024 | Change |
|--------|-----------|-----------|--------|
| Total Orders | 10,500 | 9,810 | -6.5% |
| Repeat Customer Orders | 6,800 | 6,100 | -10.3% |
| Delivery Cancellations | 340 | 470 | +38% |

**Insight:** Drop mainly caused by **repeat customer inactivity** and **rising delivery cancellations**.

---

## 💡 **Business Impact**

🔹 Helped identify key operational inefficiencies and customer churn points  
🔹 Improved decision-making for marketing and logistics teams  
🔹 Supported data-driven actions that can boost customer retention and satisfaction  

---

## 📂 **Project Structure**
Swiggy_RCA_Project/
│
├── sql_scripts/
│ ├── monthly_orders.sql
│ ├── customer_segment.sql
│ ├── delivery_summary.sql
│
├── notebooks/
│ └── Swiggy_RCA.ipynb
│
│
├── data/
│ └── (source: Kaggle link)
│
└── README.md
