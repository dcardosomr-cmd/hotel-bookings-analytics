# Hotel Bookings Analytics

## Project Overview

This project analyzes a comprehensive hotel bookings dataset containing 119,210 records from two hotel types (City Hotel and Resort Hotel) spanning the period from 2015 to 2017. The primary objective was to understand how booking patterns and cancellations impact hotel revenue and operational efficiency.

The analysis addresses critical business questions around booking behavior, cancellation rates, revenue optimization, and market segmentation to provide actionable insights for hotel management decision-making.

## Dataset Information

- **Records**: 119,210 bookings (after data cleaning)
- **Period**: 2015-2017
- **Hotel Types**: City Hotel and Resort Hotel
- **Key Variables**: 32 columns including hotel type, cancellation status, lead time, arrival dates, guest demographics, market segments, room types, ADR (Average Daily Rate), and special requests

## Methodology

The project was developed using a multi-stage analytical approach:

### 1. Data Cleaning and Preparation (Python)

Using Python (Pandas, NumPy, Seaborn, Matplotlib), the following data quality processes were implemented:

**Data Integrity Checks:**
- Identification and removal of "ghost guests" (bookings with 0 adults, children, and babies) - 180 records removed
- Detection of negative ADR values - 1 record identified
- Validation of booking patterns and reservation statuses

**Missing Value Treatment:**
- Null values in numerical columns (`agent`, `company`, `children`) replaced with 0
- Null values in `country` field replaced with "undefined" to preserve categorical information

**Data Type Optimization:**
- Date fields converted to `datetime` format
- Numerical fields standardized to appropriate integer types
- Categorical variables converted to `category` type for efficient memory usage

**Output**: Clean dataset exported as `hotel_bookings_CLEAN.csv` (119,210 records)

### 2. Exploratory Data Analysis (SQL)

Comprehensive SQL queries were developed and executed in SQL Server to analyze:

**Booking Patterns Analysis:**
- Total bookings by hotel type
- Booking and cancellation trends by quarter and year
- Seasonal patterns and peak periods
- Market segment distribution and performance

**Cancellation Analysis:**
- Overall cancellation rates by hotel type
- Cancellation patterns by quarter, market segment, and year
- Lead time impact on cancellation rates
- Risk assessment by hotel type, quarter, and market segment

**Revenue Analysis (ADR):**
- Average Daily Rate by hotel, period, and room type
- Price variation analysis by deposit type and stay type (weekend/weekday)
- Revenue per booking calculations
- Estimated revenue loss from cancellations
- ADR distribution and cancellation correlation

**Lead Time Analysis:**
- Lead time distribution by hotel and market segment
- Relationship between lead time and cancellation rates
- Lead time patterns by country and guest type (new vs. repeated)
- Impact of waiting list on bookings

**Advanced Metrics:**
- Created SQL views for reusable analysis (valid ADR bookings, room average prices, cancellation losses)
- Family composition analysis and booking patterns
- Room type pricing and demand analysis

### 3. Data Visualization (Power BI)

Interactive dashboards were created to visualize:
- Booking trends and cancellation patterns over time
- Market segment performance comparison
- Revenue analysis and loss estimation
- Geographic booking distribution
- Lead time and cancellation rate relationships
- 
The project includes comprehensive Power BI dashboards organized into multiple analytical views:

#### Temporal Analysis Dashboards

**Revenue Analysis Dashboard**
- Average booking lead time: 104.11 days
- Maximum booking lead time: 737 days  
- Total rooms reserved: 119.21K
- Total cancelled reservations: 44.199K
- Cancellation rate: 37.08%
- Revenue trends by quarter and room type
- Average lead time analysis by assigned room type
- Revenue vs. lead time correlation visualization

**Reservations Dashboard**
- Temporal heatmap showing booking density by month (2015-2017)
- Geographic distribution map of bookings by nationality
- Booking distribution by lead time groups (0-7, 8-15, 16-30, 31-60, 61-120, 121-180, 180+ days)
- Market segment analysis (Groups, Online TA, Direct, Corporate, Complementary, Aviation, Undefined)

#### General Analysis Dashboards

**Global Overview Dashboard**
- Total rooms reserved: 119.21K
- Total revenue: €12.16M
- Potential cancelled revenue: €558.84K
- Total cancelled reservations: 44.199K
- Cancellation rate: 37.08%
- Revenue by market segment (Online TA, Offline TA/TO, Groups, Direct, Corporate, Aviation, Complementary, Undefined)
- Effective reservations vs. total cancellations comparison by hotel type
- Cancellations by quarter analysis (T1-T4 across 2015-2017)

**Market Segment Heatmap**
- Detailed temporal perspective showing cancellation patterns
- Breakdown by hotel type (City Hotel vs. Resort Hotel)
- Year-over-year comparison (2015, 2016, 2017)
- Quarterly distribution (T1, T2, T3, T4) for each market segment:
  - Aviation (0.12%)
  - Complementary (0.13-0.20%)
  - Corporate (1.45-2.24%)
  - Direct (2.39-4.38%)
  - Groups (21.77-27.36%)
  - Offline TA/TO (16.21-18.78%)
  - Online TA (32.78-46.91%)
  - Undefined (0.00%)

#### Financial Analysis Dashboards

**Revenue by Family Composition**
- Total rooms reserved: 119.21K
- Total revenue: €12.16M
- Potential cancelled revenue: €558.84K
- Average revenue per booking: €101.97
- Cancellation rate: 37.08%
- Revenue trends by quarter (T3 2015 - T3 2017)
- Cancellation rate by revenue groups (€0-49, €50-99, €100-149, €150-199, €200-250, €250+)
- Total reservations vs. average revenue by family type:
  - With babies
  - With children
  - Complete family
  - Children only
  - Infant only
  - Without dependents

**Market Segment Revenue Analysis**
- Total bookings by segment (Online TA, Offline TA/TO, Groups, Direct, Corporate, Complementary, Aviation, Undefined)
- Average revenue by segment:
  - Online TA: €117.32
  - Direct: €115.63
  - Aviation: €100.99
  - Offline TA/TO: €87.48
  - Groups: €79.56
  - Corporate: €69.53
  - Undefined: €15.00
  - Complementary: €2.95
- Geographic distribution of bookings worldwide

### Dashboard Visualizations

The Power BI dashboards feature:
- **Interactive Filters**: Year selection (2015-2017), quarter selection (All/T1/T2/T3/T4), hotel type toggle (City Hotel/Resort Hotel), cancelled booking filter (Yes/No)
- **Time Series Visualizations**: Line charts showing trends over time for key metrics
- **Comparative Analysis**: Side-by-side hotel type comparisons
- **Geographic Maps**: Interactive world map showing booking origins
- **Heatmaps**: Temporal and categorical heatmaps for pattern identification
- **KPI Cards**: Real-time metric tracking with trend indicators
- **Bar Charts**: Market segment and revenue group distributions

> **Note**: Interactive Power BI dashboards are available in the `/reports` folder. The dashboards provide drill-down capabilities and real-time filtering for detailed analysis.

## Key Findings

Based on the exploratory analysis conducted:

### Booking Patterns
- City Hotel showed higher booking volumes compared to Resort Hotel
- Significant seasonal variations observed, with peak booking periods during summer months (Q3)
- Online travel agencies (Online TA) represented the dominant market segment

### Cancellation Insights
- Overall cancellation rate: approximately 37%
- Cancellation rates varied significantly by:
  - Market segment (Groups and Online TA showed higher cancellation rates)
  - Lead time (longer lead times correlated with higher cancellation probability)
  - Quarter and seasonality

### Revenue Impact
- Cancellations with ADR = 0 represented significant potential revenue loss
- Premium room types showed different cancellation patterns than standard rooms
- Deposit type strongly influenced both booking confirmation and cancellation rates

### Lead Time Analysis
- Average lead time varied considerably by market segment
- Longer lead times (120+ days) associated with higher cancellation risk
- Repeated guests showed shorter, more predictable lead times

## Technologies Used

- **Python**: Data cleaning, transformation, and initial exploration
  - Libraries: Pandas, NumPy, Seaborn, Matplotlib
- **SQL Server**: Advanced exploratory analysis and business intelligence queries
- **Power BI**: Interactive dashboard development and data visualization
- **Jupyter Notebook**: Documentation of data processing workflow

## Repository Structure

```
hotel-bookings-analytics/
├── data/
│   ├── hotel_bookings_RAW.csv          # Original dataset
│   └── hotel_bookings_CLEAN.csv        # Cleaned dataset
├── notebooks/
│   ├── Tratamento-dos-Dados.ipynb      # Data cleaning process (Jupyter)
│   └── Tratamento-dos-Dados.html       # HTML export of notebook
├── src/
│   └── Análise Exploratória - Documentação Interna.sql  # SQL queries
├── reports/
│   └── Análise Exploratória - Documentação...          # Analysis documentation
└── README.md
```

## Business Recommendations

Based on the analytical findings:

1. **Dynamic Pricing Strategy**: Implement variable deposit requirements based on lead time to reduce cancellation risk
2. **Market Segment Focus**: Develop targeted retention strategies for high-cancellation segments
3. **Overbooking Optimization**: Use cancellation rate patterns to optimize overbooking strategies by season and segment
4. **Lead Time Management**: Implement early booking incentives with stricter cancellation policies for long lead-time reservations
5. **Revenue Protection**: Consider deposit structures that better protect against last-minute cancellations

## How to Use This Repository

1. **Data Cleaning**: Review the Jupyter notebook in `/notebooks` to understand the data preparation process
2. **SQL Analysis**: Explore the SQL queries in `/src` for detailed analytical approaches
3. **Data Files**: Access raw and cleaned datasets in `/data` folder
4. **Documentation**: Refer to `/reports` for detailed analysis documentation

## Project Insights

This project demonstrates:
- End-to-end data analysis workflow from raw data to actionable insights
- Integration of Python for data cleaning with SQL for business analysis
- Practical application of data analytics to solve real business problems
- Revenue impact quantification and risk assessment methodologies

## Future Enhancements

- Machine learning model development for cancellation prediction
- Real-time dashboard integration with hotel management systems
- Customer segmentation analysis using clustering techniques
- Predictive analytics for optimal pricing strategies

## Author

**dcardosomr-cmd**

*Data Analytics Project - Hotel Bookings Dataset Analysis*

---

*Last Updated: January 2026*
