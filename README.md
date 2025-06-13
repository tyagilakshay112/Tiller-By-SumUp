# 🏡 Tiller Data Analytics Portfolio  
### By SumUp  

---

## 📌 Overview

This project leverages data analytics to provide strategic insights into the French restaurant market, identifying **high-demand areas**, **affordability zones**, and **growth potential**. It integrates modern data engineering and visualization tools to support smarter decision-making for stakeholders — from restaurant owners to internal sales teams.

---

## 🛠️ 1. Data Collection (ELT Pipeline)

### 📁 Data Sources
- **Google Drive**: Stores raw datasets in Google Sheets.
- **Fivetran**: Automates extraction and loading into Google BigQuery.

### 🗄️ Data Storage
- **BigQuery**: Acts as the central data warehouse for raw and transformed datasets.

---

## 🔄 2. Data Transformation (Preprocessing & Modeling)

### 🧰 Tools & Techniques
- **Language**: SQL  
- **Cleaning**: Removing missing values, duplicates, and formatting issues  
- **Modeling**: Star schema with dimension and fact tables  
- **Materialization**: Tables in BigQuery for optimized query performance  

### 🔧 Example Transformations
- Date normalization for accurate time-based joins and aggregations  
- Revenue calculations:
  - `avg_price_per_customer`
  - `order_duration_minutes`
- Dimension tables: `refined_category`, `season`, `weekday`, `time_slot`, `hour`
- Fact table: `final_table_kpi_zipcode` using foreign keys from dimension tables

---

## 📊 3. KPIs and Strategic Insights

### 🎯 Business Applications

#### 1. External Dashboard – For Restaurant Owners

| **Feature**                    | **Description**                                         | **Basic** | **Premium** |
|-------------------------------|---------------------------------------------------------|-----------|-------------|
| Personalized KPIs             | Revenue, avg order size, orders/day, product mix, etc.  | ✔️        | ✔️          |
| Dashboard Functionality       | Time filtering, drill-downs                            | ✔️        | ✔️          |
| Training Resources            | Onboarding guides & videos                             | ✔️        | ✔️          |
| Strategic Insights            | Expert KPI review & advice                             | ❌        | ✔️          |
| Forecasts                     | Predictive revenue analytics                           | ❌        | ✔️          |

💡 **Revenue opportunity**: Enables new SaaS income streams while helping restaurants improve operations.

#### 2. Internal Sales Enablement – For Tiller’s Sales Team
- Target underpenetrated regions (geographic white spaces)  
- Prioritize high-value leads  
- Track acquisition trends over time  
- Align outreach with SumUp’s card-payment infrastructure  

#### 3. Market Consulting – For Restaurateurs and Entrepreneurs
- Benchmark performance across segments (e.g., cafés vs. brasseries)  
- Use machine learning to detect revenue-impacting features  
- Build forecasts for seasonality and planning  

### 📈 Key KPIs
- Total revenue  
- Customers served  
- Revenue per customer  
- Order frequency  
- Category performance  

---

## 🐍 4. Statistical & Machine Learning Analysis (Python)

### 📊 Statistical Tests

#### Methodology
- **Dependent Variable**: Revenue (continuous)
- **Continuous Variables**: Correlation analysis
- **Categorical Variables**:
  - Z-test (e.g., seasonal comparison)
  - Kruskal-Wallis test (e.g., zip codes, time slots)

#### Findings
- **Positive correlation with revenue**: Group size, Order size  
- **No correlation**: Table duration  
  - ➤ Insight: Focus on optimizing table turnover instead of increasing sitting time  
- **Z-test**: Significant difference in revenue between summer & winter (p < 0.001)  
- **Kruskal-Wallis**: Revenue varies significantly by time slot and zip code  
  - ➤ Insight: Adapt menus, prices, and staffing by region and time of day  

---

### 🤖 Machine Learning – Time Series Forecasting

#### Methodology
- Tool: **Prophet by Facebook**
- Steps:
  - Added regressors and holiday effects
  - Interpolated missing values
  - Trained model and generated forecast
  - Visualized with trend and seasonal decomposition

#### Results
- Forecast shows predictable seasonal revenue trends  
- Component plots reveal:
  - Weekly cycles  
  - Holiday spikes  
  - Long-term growth patterns  

---

## 📉 5. Dashboarding & Visualization

### 🧭 Internal – Sales Team Dashboard  
**Built using Looker**

#### Key Features
- Client KPIs: Revenue, devices, customer count, restaurant type  
- Geographic coverage: Map of client zones and white spaces  
- Acquisition timeline: Quarterly client growth  
- Device breakdown: Insights into Tiller product adoption  
- Payment tracking: Cash vs. card payments (SumUp alignment)  

🎯 **Value**: Enables strategic outreach and cross-sell opportunities.

---

### 📬 External – Restaurant Revenue Overview  
**Compliant with GDPR (aggregated metrics only)**

#### Revenue Highlights
- Total revenue: €21.19M  
- Customers served: 1M+  
- Avg revenue per customer: €16.90  
- Avg daily orders: 550+  
- Avg daily revenue: €11.6K  

#### Category Insights
- **Top ordered**: Draft beer, soft drinks, main courses  
- **Revenue contributors**:
  - Main courses: 22.7%
  - Soft drinks: 16.8%
  - Wine: 10.3%
  - Daily specials & desserts: ~18%

📌 **Implications**:
- Optimize menus around bestsellers  
- Promote high-performing drink options  
- Use daily specials to boost revenue  

#### Dashboard Elements
- 🔽 Restaurant selector (drop-down list)  
- 📆 Date range control  
- 📊 Charts:
  - Scorecards (Total Revenue, Revenue Per Customer, etc.)  
  - Vertical bar charts (Top Ordered Categories)  
  - Donut charts (Revenue Share by Category)  

---

## ✅ Key Takeaways
- ⚙️ Automated ELT pipeline: **Fivetran → BigQuery → dbt**  
- 🧠 SQL-driven data modeling using star schema  
- 📊 Interactive dashboards built with **Looker**  
- 📍 Geographic & temporal insights into restaurant performance  
- 🔮 Forecasting and statistical analysis for smarter planning  
- 💰 Supports data monetization via SaaS products, internal tooling, and consulting
