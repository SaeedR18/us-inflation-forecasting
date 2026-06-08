# U.S. Inflation Analysis and Forecasting

**Tools:** R (tidyverse, forecast, tseries) | **Dataset:** U.S. Annual CPI Inflation 1961–2023 | **Domain:** Economic Analytics & Time Series Forecasting

---

## Project Overview

This project analyzes U.S. annual CPI inflation trends across four distinct monetary policy eras and builds an ARIMA time series model to forecast near-term inflation. The goal was to apply statistical rigor to a real-world economic dataset — comparing inflation behavior across policy regimes and producing validated forecasts aligned with Bureau of Labor Statistics actuals.

---

## Business Questions Answered

- How has U.S. inflation behavior differed across major monetary policy eras?
- Are the differences in average inflation rates between eras statistically significant?
- What does a data-driven ARIMA model forecast for near-term U.S. inflation?

---

## Dataset

**Source:** [Macrotrends](https://www.macrotrends.net/countries/USA/united-states/inflation-rate-cpi) & Bureau of Labor Statistics (BLS)
**File:** `data/us_inflation.csv`
**Records:** 63 annual observations (1961–2023)
**Fields:**

| Field | Description |
|---|---|
| `year` | Calendar year |
| `inflation_rate` | Annual U.S. CPI inflation rate (%) |

---

## Methodology

### 1. Data Import & Tidying
- Loaded Macrotrends CSV using `readr`
- Selected and renamed relevant columns
- Cast `year` to integer and `inflation_rate` to double
- Arranged chronologically for time series construction

### 2. Monetary Policy Era Classification
Four eras defined using `case_when()`:

| Era | Years | Description |
|---|---|---|
| Pre-Volcker | 1960–1979 | High inflation, oil shocks |
| Volcker–Greenspan | 1980–1999 | Disinflation and stabilization |
| Post-Great Recession | 2000–2019 | Low inflation, quantitative easing |
| Pandemic Rebound | 2020–2024 | COVID-era inflation surge |

### 3. Historical Visualization
- Line chart of annual inflation rate 1960–2023
- 2% Fed target reference line (dashed)

### 4. Statistical Testing — ANOVA & Tukey HSD
- One-way ANOVA: `aov(inflation_rate ~ era)`
- Tukey HSD post-hoc test for pairwise era comparisons
- Tests whether mean inflation rates differ significantly across eras

### 5. ARIMA Forecasting
- Converted inflation series to `ts` object
- Used `auto.arima()` for automatic order selection (AIC-optimized)
- `checkresiduals()` for Ljung-Box test and ACF diagnostic plots
- Generated 3-year forecast with 80% and 95% confidence intervals
- Visualized using `autoplot()` from the `forecast` package

---

## Key Findings

- **ANOVA results** confirmed statistically significant differences in mean inflation across all four policy eras (p < 0.05)
- **Tukey HSD** identified the Pre-Volcker and Pandemic Rebound eras as most significantly different from the Post-Great Recession low-inflation period
- **ARIMA model** produced forecasts consistent with BLS actuals — validating the model's predictive accuracy against real-world outcomes
- The 2% Fed target line underscored how rarely inflation stayed near target outside the 2000–2019 era

---

## Repository Structure

```
us-inflation-forecasting/
├── README.md          ← Project overview and methodology
├── analysis.R         ← Full R analysis script
└── data/
    └── us_inflation.csv  ← Annual CPI inflation dataset (1961–2023)
```

---

## How to Run

### Prerequisites
```r
install.packages(c("tidyverse", "forecast", "tseries"))
```

### Steps
1. Clone the repository
2. Open `analysis.R` in RStudio
3. Run the script — all packages install automatically if not present
4. Outputs: historical line chart, ARIMA forecast plot, ANOVA summary, Tukey HSD results, residual diagnostics

> **Note:** The script references `data/us_inflation.csv` — ensure the data folder is in the same directory as `analysis.R`.

---

## Skills Demonstrated

- **Time Series Analysis:** ARIMA model construction, automatic order selection, residual diagnostics, multi-year forecasting
- **Statistical Testing:** One-way ANOVA, Tukey HSD post-hoc pairwise comparison, Ljung-Box test
- **Data Wrangling:** CSV import, column selection/renaming, type casting, chronological ordering
- **Data Visualization:** Historical trend line charts, ARIMA forecast plots with confidence intervals, ACF diagnostic plots
- **Economic Domain Knowledge:** Monetary policy era classification, Fed inflation targeting, CPI interpretation
- **R Proficiency:** tidyverse, forecast, tseries, ggplot2, auto.arima, checkresiduals

---

## Author

**Saeed Rahman** — Data Science & Analytics, University of South Florida

*Course project — LIS 4370 R Programming, University of South Florida, Spring 2026*
