# City of Toronto Approved* Budget Visualization

*The 2013 budget was recommended and not approved.
 
## Data Source: [Toronto Open Data Portal](https://open.toronto.ca/dataset/budget-operating-budget-program-summary-by-expenditure-category/)

### Application link: 
 
## Data Cleaning

The data files collected from the City Open Data Portal are in multiple formats. For years 2010 - 2014 (2010 was extracted from the 2011 file), excel was used due to an incosistency in file organization.
From 2015 onwards, [Python](https://github.com/Shafquat/D3_budget_viz/blob/master/Join_files.ipynb) was used to group and consolidate the data.

The data was subsetted into 5 columns (Year, Program, Category, Expense, and Revenue) which are our key fields when creating the Sankey Diagram.
The Program and Category fields needed to be cleaned as there are multiple different iterations on how to spell names.


