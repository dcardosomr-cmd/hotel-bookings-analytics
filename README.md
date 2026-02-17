# Hotel-Bookings-Analytics

## Project Overview

This project analyses 119,210 hotel booking records from a City Hotel and a Resort Hotel (2015–2017) to understand how booking patterns, cancellations, and market segments impact revenue and operations. The dataset was cleaned with Python, explored with SQL Server, and visualised in Power BI to deliver actionable insights for hotel management.

**Goal:** Quantify the revenue impact of cancellations, identify which booking segments carry the highest risk, and provide data-driven pricing and retention strategies to reduce the estimated €558K in annual revenue loss.

**Tools & Technologies:** Python (Pandas, NumPy, Seaborn, Matplotlib) · SQL Server (CTEs, views, window functions) · Power BI (interactive dashboards) · Jupyter Notebook · Git / GitHub

---

## Executive Summary

| Metric | Value |
|--------|-------|
| Total Bookings | 119,210 |
| Total Revenue | €12.16M |
| Cancelled Reservations | 44,199 |
| Cancellation Rate | 37.08% |
| Potential Lost Revenue | €558.84K |
| Avg Revenue per Booking | €101.97 |
| Avg Lead Time | 104.11 days |
| Max Lead Time | 737 days |

### Top Findings

- **37% of all bookings are cancelled**, with City Hotel showing significantly higher cancellation volume than Resort Hotel. This is the single largest operational and revenue risk.
- **Online Travel Agencies dominate** both bookings (46.91% of cancellations) and revenue (€117.32 avg per booking), making them the highest-volume but also highest-risk channel.
- **Lead time is the strongest cancellation predictor:** bookings made 120+ days in advance cancel at dramatically higher rates than those made within 30 days.
- **Summer peaks, winter troughs:** Q3 (July–September) consistently generates the highest booking volumes and revenue across both hotel types.
- **Groups segment** shows 21–27% of cancellations despite lower volume — a disproportionate cancellation risk that needs targeted retention.
- **Deposit policy works:** Non-refundable deposits nearly eliminate cancellations, but the majority of bookings carry no deposit at all.

---

## 1. Global Overview & Cancellation Patterns

![Global Overview Dashboard](dashboards/Screenshot_2026-01-04_200653.png)

The overall cancellation rate of 37.08% means more than 1 in 3 bookings never converts to a stay. City Hotel bears the heavier burden, with significantly higher effective reservations but also higher absolute cancellation volume compared to Resort Hotel.

Revenue by market segment shows Online TA as the dominant channel for both hotel types, followed by Offline TA/TO and Groups. Cancellations by quarter reveal that City Hotel consistently cancels at higher rates than Resort Hotel across all periods from T3 2015 through T3 2017.

| Market Segment | Cancellation Share | Avg Revenue | Risk Level |
|---------------|-------------------|-------------|------------|
| Online TA | 32.78–46.91% | €117.32 | High volume, high cancel |
| Offline TA/TO | 16.21–18.78% | €87.48 | Moderate |
| Groups | 21.77–27.36% | €79.56 | Disproportionate risk |
| Direct | 2.39–4.38% | €115.63 | Lowest cancel rate |
| Corporate | 1.45–2.24% | €69.53 | Stable, low cancel |
| Complementary | 0.13–0.20% | €2.95 | Negligible |
| Aviation | 0.12% | €100.99 | Negligible |

Direct bookings generate nearly as much revenue per booking as Online TA (€115.63 vs €117.32) while cancelling at a fraction of the rate. This is the strongest argument for investing in direct booking channels.

---

## 2. Market Segment Heatmap

![Market Segment Heatmap](dashboards/Screenshot_2026-01-04_200736.png)

The temporal heatmap breaks down cancellation patterns by hotel type, year, quarter, and market segment — revealing exactly where the problem concentrates.

Key patterns from the heatmap:

- **City Hotel** carries the bulk of cancellations across all segments, with Online TA peaking at 32.78% and Groups at 21.77%
- **2016** shows the highest booking volumes but also the highest absolute cancellations, suggesting growth without cancellation management leads to proportionally larger losses
- **Resort Hotel** shows lower cancellation rates across the board, with Online TA at 14.14% and Groups at 5.60%
- **Quarterly breakdown** reveals Q3 concentration for Online TA cancellations, coinciding with the highest booking volume period

Year-over-year, the data shows cancellation patterns are structural rather than seasonal — the same segments cancel at similar rates regardless of quarter, suggesting the root cause is booking behaviour (lead time, deposit policy) rather than time of year.

---

## 3. Revenue & Lead Time Analysis

![Revenue Analysis Dashboard](dashboards/Screenshot_2026-01-04_200939.png)

Total revenue across both properties reached €12.16M over the reporting period, with an average lead time of 104.11 days and a maximum of 737 days (2 years in advance). The room pricing table reveals significant ADR variation by room type and hotel:

| Room Type | City Hotel ADR | Resort Hotel ADR |
|-----------|---------------|-----------------|
| A | €96.70 | €81.41 |
| B | €94.29 | €101.75 |
| C | €102.41 | €114.47 |
| D | €121.75 | €86.88 |
| E | €144.48 | €107.61 |
| F | €178.65 | €120.73 |
| G | €184.98 | €159.84 |
| H | — | €171.38 |

City Hotel commands higher ADR for premium room types (E–G), while Resort Hotel shows more competitive pricing on standard rooms. The lead time chart shows that revenue concentrates in the 0–60 day booking window, with bookings made 180+ days out contributing minimal revenue but significant cancellation risk.

---

## 4. Reservations & Geographic Distribution

![Reservations Dashboard](dashboards/Screenshot_2026-01-04_201005.png)

The temporal heatmap reveals clear seasonality: summer months (June–August) show the darkest concentration across all three years, while January and November are consistently the weakest. Data coverage begins in T3 2015 and runs through T3 2017, with 2016 showing the fullest year of bookings.

Geographically, European guests dominate — Portugal, the UK, France, Spain, and Germany account for the majority of bookings, as shown in the nationality map. The lead time distribution shows distinct clusters: a large group of bookings in the 0–7 day window, a substantial mid-range cluster (31–60 days), and a long-lead segment (180+ days) with the highest cancellation risk.

Average lead time by market segment shows Groups booking furthest in advance (~200 days), followed by Online TA (~100 days), while Direct and Corporate bookings are made closer to arrival — which partly explains their lower cancellation rates.

---

## 5. Revenue by Family Composition & Cancellation Risk

![Revenue by Family Composition](dashboards/Screenshot_2026-01-04_200837.png)

Revenue by quarter shows City Hotel consistently outperforming Resort Hotel, with both properties peaking in Q3 each year. The quarterly trend from T3 2015 through T3 2017 shows steady growth with clear seasonal cycles.

The cancellation rate by revenue group reveals an important pattern:

| Revenue Group | Cancellation Rate |
|--------------|------------------|
| €0–49 | ~20% |
| €50–99 | ~35% |
| €100–149 | ~38% |
| €150–199 | ~37% |
| €200–250 | ~38% |
| €250+ | ~30% |

The €100–€250 range shows the highest cancellation rates, suggesting a "middle-market squeeze" where price-sensitive guests are most likely to find a better deal and cancel. Both the lowest and highest revenue tiers cancel less frequently.

The family composition chart shows that guests without dependents generate the overwhelming majority of both reservations and revenue, while family bookings (with children, babies, or complete families) represent a smaller but distinct segment.

---

## 6. Market Segment Revenue & Geography

![Market Segment Revenue](dashboards/Screenshot_2026-01-04_200911.png)

This dashboard breaks down both booking volume and average revenue by market segment. Online TA leads in total reservations (~56K bookings) and commands the highest average revenue at €117.32 per booking. Direct bookings follow closely at €115.63 — nearly identical revenue but with far lower cancellation risk.

The segment revenue ranking reveals where value and risk diverge:

| Segment | Avg Revenue | Volume | Value Assessment |
|---------|------------|--------|-----------------|
| Online TA | €117.32 | Highest | High value, high risk |
| Direct | €115.63 | Low | High value, low risk |
| Aviation | €100.99 | Minimal | Niche |
| Offline TA/TO | €87.48 | High | Moderate value |
| Groups | €79.56 | Moderate | Low value, high risk |
| Corporate | €69.53 | Low | Stable, predictable |
| Undefined | €15.00 | Minimal | Data quality issue |
| Complementary | €2.95 | Minimal | Non-revenue |

The geographic map confirms European concentration, with Portugal as the dominant source market. This combined view of volume, revenue, and geography provides the clearest picture of where to focus acquisition and retention efforts.

---

## 7. Room Revenue & Lead Time Correlation

![Room Revenue Dashboard](dashboards/Screenshot_2026-01-04_201025.png)

The revenue vs. lead time chart confirms the critical relationship: bookings made 0–30 days before arrival generate the highest total revenue, while the 180+ day window contributes proportionally less revenue despite occupying cancellation risk for the longest period.

Lead time by assigned room type shows that premium rooms (F, G, H) tend to be booked further in advance, which explains their higher cancellation exposure. Standard room types (A, B) show shorter, more predictable lead times.

---

## 8. Strategic Recommendations

### Priority 1: Reduce Cancellation Revenue Loss
The 37% cancellation rate and €558K in lost revenue is the primary business problem. Implement tiered deposit requirements based on lead time: bookings made 120+ days out should require a non-refundable deposit, as this segment shows the highest cancellation probability. Based on the data, non-refundable deposits nearly eliminate cancellations.

### Priority 2: Invest in Direct Booking Channels
Direct bookings generate €115.63 avg revenue (comparable to Online TA's €117.32) with dramatically lower cancellation rates (2.39–4.38% vs 32.78–46.91%). Shifting even 10% of Online TA volume to direct channels could reduce cancellations significantly while maintaining revenue per booking.

### Priority 3: Targeted Group Retention
Groups represent 21–27% of cancellations despite lower booking volumes. Implement confirmation calls 30 days before arrival for group bookings, and require partial deposits for groups booked 60+ days out.

### Priority 4: Seasonal Overbooking Strategy
With 37% cancellation rates in peak Q3 months, the data supports strategic overbooking during summer. Use segment-specific cancellation rates (Online TA vs Direct vs Groups) to calculate safe overbooking margins by month and room type.

### Priority 5: Mid-Market Pricing Review
The €100–€250 revenue tier shows the highest cancellation rates (~37–38%), suggesting price sensitivity. Test bundled offers (breakfast included, late checkout) in this range to reduce cancellation incentive rather than competing on price alone.

---

## Data Cleaning Summary

Using Python (Pandas, NumPy), the raw dataset was cleaned and prepared:

- **180 "ghost guest" records removed** — bookings with 0 adults, 0 children, and 0 babies
- **1 negative ADR record identified** and handled
- **Null values treated:** numerical columns (`agent`, `company`, `children`) filled with 0; `country` nulls replaced with "undefined"
- **Data types optimised:** dates converted to `datetime`, numericals standardised to integers, categoricals converted for memory efficiency
- **Output:** `hotel_bookings_CLEAN.csv` (119,210 records)

---

## SQL Analysis Highlights

The exploratory analysis was performed in SQL Server with comprehensive queries covering:

- **Booking patterns:** total bookings by hotel type, quarterly/yearly trends, seasonal peaks, market segment distribution
- **Cancellation analysis:** rates by hotel type, quarter, market segment, and lead time; risk assessment matrices
- **Revenue analysis:** ADR by hotel, period, room type, and deposit type; estimated revenue loss from cancellations; per-booking revenue calculations
- **Lead time analysis:** distribution by hotel and segment; cancellation correlation; country and guest type patterns
- **Reusable SQL views** created for valid ADR bookings, room average prices, and cancellation loss estimation

Full SQL documentation is available in `/src`.

---

## Repository Structure

```
hotel-bookings-analytics/
├── README.md
├── dashboards/
│   ├── Screenshot_2026-01-04_200653.png    # Global Overview
│   ├── Screenshot_2026-01-04_200736.png    # Market Segment Heatmap
│   ├── Screenshot_2026-01-04_200837.png    # Revenue by Family Composition
│   ├── Screenshot_2026-01-04_200911.png    # Market Segment Revenue & Geography
│   ├── Screenshot_2026-01-04_200939.png    # Revenue & Lead Time
│   ├── Screenshot_2026-01-04_201005.png    # Reservations & Geography
│   └── Screenshot_2026-01-04_201025.png    # Room Revenue & Lead Time
├── data/
│   ├── hotel_bookings_RAW.csv              # Original dataset (119,390 records)
│   └── hotel_bookings_CLEAN.csv            # Cleaned dataset (119,210 records)
├── notebooks/
│   ├── Tratamento-dos-Dados.ipynb          # Data cleaning notebook
│   └── Tratamento-dos-Dados.html           # HTML export
├── src/
│   └── Análise Exploratória - Documentação Interna.sql  # SQL queries
└── reports/
    └── Análise Exploratória - Documentação...           # Analysis documentation
```

---

## Future Enhancements

- Machine learning model for cancellation prediction using lead time, segment, and deposit features
- Real-time dashboard integration with hotel PMS systems
- Customer segmentation using clustering to identify high-value guest profiles
- A/B testing framework for deposit policy changes

---

*Last Updated: January 2026*
