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
