# edenR

The **edenR** package provides functions to retrieve, process and summarize the EDEN water depth data. The data begin in 1991 and are continuously updated today.

## Installation

You can install edenR from github with:

    # install.packages("remotes")
    remotes::install_github("weecology/edenR")

## Examples

1.  Download data:

<!-- -->
    download_eden_depths()
    
2.  Get data tables

<!-- -->
    eden_depths <- get_eden_data()
    

# EDEN Gage Data 
For additional info about the Everglades Depth Estimation Network (EDEN): http://sofia.usgs.gov/eden

These data have been downloaded from the EDEN database via their [EDEN THREDDS server](http://sflthredds.er.usgs.gov/). Data are also accessible via the [Explore and View EDEN (EVE) web application](https://sofia.usgs.gov/eden/eve/).

See the [EDEN Gage Data Readme](EDEN_Gage_Data_Download_Readme.md) for metadata.

## Suggested Data Citation
The only provision for use of these datasets is that the creators request acknowledgement of the EDEN website and the USGS in all instances of publication or reference. They suggest using the following text:

The authors acknowledge the Everglades Depth Estimation Network (EDEN) project and the US Geological Survey for providing the [insert data type here] for the purpose of this research/report.

Contact: http://sofia.usgs.gov/eden/contacts.php