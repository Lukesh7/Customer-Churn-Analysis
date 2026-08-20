# Telecom Customer Churn Analysis
import pandas as pd

# Phase 1 : Data cleaning

#1. Load Dataset
df = pd.read_csv(r"C:\Users\LUKESH\OneDrive\Desktop\Telecom-Customer-Churn-Analysis\data\raw\Telco-Customer-Churn.csv")
print("Dataset Shape :", df.shape) 
print(df.head(10))

#column names
print("Column names:")
print(df.columns.tolist())

#2. Checking Missing Values
print("\nMissing Values:", df.isnull().sum())

#3. Check Duplicates Values
print("Duplicates Rows :", df.duplicated().sum())

#4. Check Duplicate Customer IDs
print("Duplicate customer IDs :", df["customerID"].duplicated().sum())

#5. Clean TotalCharges

# convert blank rows to NaN
df["TotalCharges"] = df["TotalCharges"].replace(" ", pd.NA)

# convert to numeric values
df["TotalCharges"] = pd.to_numeric(df["TotalCharges"], errors="coerce")

# replace missing TotalCharges with 0
df["TotalCharges"] = df["TotalCharges"].fillna(0)

#6. Convert SeniorCitizen
df["SeniorCitizen"] = df["SeniorCitizen"].map({0 : "No", 1 : "Yes"})

#7. Create Churn Flag
df["ChurnFlag"] = df["Churn"].map({"No" : 0, "Yes" : 1})

#8. Create Tenure Group
df["TenureGroup"] = pd.cut(
    df["tenure"], 
    bins = [-1, 12, 24, 48, float("inf")], 
    labels = ["0-12 months", "13-24 months", "25-48 months", "49+ months"]
    )

#9. Create Monthly Charges Group
df["MonthlyChargesGroup"] = pd.cut(
    df["MonthlyCharges"],
    bins = [-float("inf"), 40, 70, float("inf")],
    labels = ["Low", "Medium", "High"]
)

#10. Final Data check
print("\nFInal Dataset Shape:")
print(df.shape)

print("\nFinal Data types:")
print(df.dtypes)

print("\nFinal Missing Values:")
print(df.isnull().sum())

#11. Save Cleaned Dataset
output_path = (r"data/cleaned/Telco-Customer-Churn-Cleaned.csv")
df.to_csv(output_path, index = False)

print("\nCleaned dataset is saved successfully !")
print(output_path)