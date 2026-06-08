
# -------- 0.  Install/load required packages 
pkgs <- c("tidyverse", "forecast", "tseries")
inst <- rownames(installed.packages())
for (p in pkgs) if (!p %in% inst) install.packages(p, repos = "https://cloud.r-project.org")
library(tidyverse)   # readr, dplyr, ggplot2, etc.
library(forecast)    # auto.arima(), forecast(), autoplot()
library(tseries)     # adf.test(), checkresiduals()

# 1.  Import and tidy the Macrotrends CSV 
inflation <- read_csv("us_inflation.csv", show_col_types = FALSE) %>% 
  select(1:2) %>%                      # keep the first two columns only
  rename(
    year           = 1,                # give them tidy names
    inflation_rate = 2
  ) %>% 
  mutate(
    year           = as.integer(year),
    inflation_rate = as.double(inflation_rate)
  ) %>% 
  arrange(year)                        # chronological order for ts()

# 2.  Create monetary-policy era factor 
inflation <- inflation %>% 
  mutate(era = case_when(
    year <= 1979 ~ "1960-1979 Pre-Volcker",
    year <= 1999 ~ "1980-1999 Volcker–Greenspan",
    year <= 2019 ~ "2000-2019 Post-Great Recession",
    TRUE         ~ "2020-2024 Pandemic Rebound"
  ))

# 3.  Visualization 1: historical path 
p_hist <- ggplot(inflation, aes(year, inflation_rate)) +
  geom_line(size = 0.8) +
  geom_hline(yintercept = 2, linetype = "dashed") +
  labs(title = "United States annual CPI inflation, 1960-2023",
       x = "Year", y = "Inflation rate (%)")
print(p_hist)

# 4.  One-way ANOVA and Tukey HSD post-hoc 
anova_fit <- aov(inflation_rate ~ era, data = inflation)
print(summary(anova_fit))
print(TukeyHSD(anova_fit))

# 5.  ARIMA model, diagnostics, and 3-year forecast 
ts_inf    <- ts(inflation$inflation_rate, start = min(inflation$year))
fit_arima <- auto.arima(ts_inf)          # order chosen by AIC
checkresiduals(fit_arima)                # Ljung–Box + ACF plots

fc     <- forecast(fit_arima, h = 3)     # next three calendar years
p_fc   <- autoplot(fc) +
  labs(title = "ARIMA forecast of U.S. CPI inflation",
       x = "Year", y = "Forecast (%)")
print(p_fc)
