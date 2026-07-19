# Bronze Layer

## What files are stored in Bronze?

The Bronze layer stores the original raw data files:

- orders_raw.csv
- customers_raw.csv
- products_raw.csv

## Why do we keep raw data unchanged?

We keep the raw data unchanged because it is the original source of information. This allows us to trace errors, compare cleaned data with the original files, and rerun the pipeline if needed.

## What problems did you notice in the raw data?

I noticed several data quality problems:

- Missing values
- Duplicate order IDs
- Duplicate customer IDs
- Invalid date formats
- Missing quantity values
- Negative and invalid quantities
- Different status names (completed, Completed, complete, done)
- Different channel names (online, Online, Store, store)
- Unknown customer IDs
- Unknown product IDs
- Missing categories
- Invalid product prices

## Which data problems could break business reports if they are not cleaned?

These problems could produce incorrect reports. Missing or invalid values can affect revenue calculations, duplicate records can count sales more than once, invalid dates can break date reports, and missing customer or product information can make business analysis inaccurate.
