# draw heat map
import seaborn as sns
sns.heatmap(df_stats, annot=True)

# Group by 'store_renamed' and sum 'm_cached_payed'
df_pareto = df.groupby('store_renamed', as_index=False)['m_cached_payed'].sum()

# Optional: Sort to see highest revenue restaurants first
df_pareto = df_pareto.sort_values(by='m_cached_payed', ascending=False)

# Display the result

df_pareto = df_pareto.set_index('store_renamed')
df_pareto


#add column to display cumulative percentage
df_pareto['cumperc'] = df_pareto['m_cached_payed'].cumsum()/df_pareto['m_cached_payed'].sum()*100
df_pareto


# perreto chart plot

import matplotlib.pyplot as plt
from matplotlib.ticker import PercentFormatter

#define aesthetics for plot
color1 = 'steelblue'
color2 = 'red'
line_size = 4

# Create basic horizontal bar plot
fig, ax = plt.subplots()
ax.barh(df_pareto.index, df_pareto['m_cached_payed'], color=color1)

# Add cumulative percentage line to plot (now along x-axis)
ax2 = ax.twiny()
ax2.plot(df_pareto['cumperc'], df_pareto.index, color=color2, marker="D", ms=line_size)
ax2.xaxis.set_major_formatter(PercentFormatter())

# Specify axis colors
ax.tick_params(axis='x', colors=color1)
ax2.tick_params(axis='x', colors=color2)

# Set labels (optional)
ax.set_xlabel('m_cached_payed')
ax.set_ylabel('id_store')
ax2.set_xlabel('Cumulative Percentage')

# Display Pareto chart
plt.show()