# Useful-R-scripts
Here're my ordinary scripts for solving daily tasks, updating marketing stats, exploring and so on.

## DailyTable.R
This [script](https://github.com/MariiaChernysh/Useful-R-scripts/blob/master/DailyTable.R) provides .csv output containing a non-formatted pivot table with several groupings.
The output will present a summary on Managers' KPIs divided by traffic sources they use. The tricky part is that different Managers can work with the same Traffic Sources and their stats should be calculated considering this issue. Data sample can be found [here](https://drive.google.com/file/d/1qc4ehDXPkuVnmfeAPpuALehgqDn1_pBC/view?usp=sharing).

## AutoGSTable.R
This [script](https://github.com/MariiaChernysh/Useful-R-scripts/blob/master/AutoGSTable.R) is designed to insert chosen data to Google Sheets automatically. Although it's not the fastest way to fill in the report, one can just launch it and deal with the other stuff while it's working. The main disadvantage of this script is it's dependency on certain data structure. All values are anchored to the relevant cells and if the order of values is changed, one should change the cells' positioning accordingly. Output example can be found [here](https://prnt.sc/vngzy1). Data sample can be found [here](https://drive.google.com/file/d/1gzQD9-_LIW7k9HO8cnM_0fOZKvaFdOQb/view?usp=sharing)


## URLnav.R
URL navigation [script](https://github.com/MariiaChernysh/Useful-R-scripts/blob/master/URLnav.R) was designed literally to browse through websites ^_^. Personally I needed this to check flows of ad campaigns my agency is running. So I wrote a function that navigates through the number of campaigns (it's pretty helpful when n=500+)
