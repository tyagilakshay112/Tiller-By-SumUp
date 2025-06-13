# checked the data distribution in regards with the time slot

import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats

# Check the distribution of 'm_cached_payed'
print("Distribution of 'm_cached_payed':")

# Histogram
plt.figure(figsize=(8, 5))
sns.histplot(df['m_cached_payed'], kde=True)
plt.title('Histogram of m_cached_payed')
plt.xlabel('m_cached_payed')
plt.ylabel('Frequency')
plt.show()

# Q-Q Plot
plt.figure(figsize=(8, 5))
stats.probplot(df['m_cached_payed'], dist="norm", plot=plt)
plt.title('Q-Q Plot of m_cached_payed')
plt.show()

# Check the distribution of 'quantity'
print("\nDistribution of 'quantity':")

# Histogram
plt.figure(figsize=(8, 5))
sns.histplot(df['quantity'], kde=True)
plt.title('Histogram of quantity')
plt.xlabel('quantity')
plt.ylabel('Frequency')
plt.show()

# Q-Q Plot
plt.figure(figsize=(8, 5))
stats.probplot(df['quantity'], dist="norm", plot=plt)
plt.title('Q-Q Plot of quantity')
plt.show()

# You can similarly check 'm_nb_customer' and 'table_turnover_minutes'
# print("\nDistribution of 'm_nb_customer':")
# plt.figure(figsize=(8, 5))
# sns.histplot(df['m_nb_customer'], kde=True)
# plt.title('Histogram of m_nb_customer')
# plt.xlabel('m_nb_customer')
# plt.ylabel('Frequency')
# plt.show()
# plt.figure(figsize=(8, 5))
# stats.probplot(df['m_nb_customer'], dist="norm", plot=plt)
# plt.title('Q-Q Plot of m_nb_customer')
# plt.show()

# print("\nDistribution of 'table_turnover_minutes':")
# plt.figure(figsize=(8, 5))
# sns.histplot(df['table_turnover_minutes'], kde=True)
# plt.title('Histogram of table_turnover_minutes')
# plt.xlabel('table_turnover_minutes')
# plt.ylabel('Frequency')
# plt.show()
# plt.figure(figsize=(8, 5))
# stats.probplot(df['table_turnover_minutes'], dist="norm", plot=plt)
# plt.title('Q-Q Plot of table_turnover_minutes')
# plt.show()