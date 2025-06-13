
##### Statistical Analysis - Correlation Analysis

import pandas as pd
#auth.authenticate_user()

# access my bigquery file

from google.colab import auth
import pandas as pd
auth.authenticate_user()

# Select the table
query = "select * from `tiller-by-sumup-461710.Tiller.final_table_kpi_zipcode` limit 1000"

# Call the table from bigquery
df = pd.read_gbq(query, project_id="tiller-by-sumup-461710")
df.head()

#doing correlation analysis
# Calculate the correlation matrix for the selected columns
df_stats = df[['m_cached_payed', 'm_nb_customer', 'table_turnover_minutes', 'quantity']].corr()

# Display the correlation matrix
print(df_stats)

#Final Test
df_stats.corr()

# draw heat map
import seaborn as sns
sns.heatmap(df_stats, annot=True)