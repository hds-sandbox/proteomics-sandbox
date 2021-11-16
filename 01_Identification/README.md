#Identification

This part of the course is about identification and quantification of peptides and proteins from raw spectral data. For this purpose, we will be working with a proteogenomic study of breast cancer tissue samples ([Satpathy, S., Jaehnig, E.J., Krug, K. et al. (2020). Microscaled proteogenomic methods for precision oncology. Nature Communications, Vol. 11,1 532](https://www.ncbi.nlm.nih.gov/pubmed/31988290)). The raw data files are available under the [Protein Data Commons](https://pdc.cancer.gov/pdc/) repository as part of the Clinical Proteomic Tumor Analysis Consotium (CPTAC): https://pdc.cancer.gov/pdc/study/PDC000325

The study is demonstrating a protocol for proteogenomic profiling based on core needle biopsies, i.e. using very small sample amounts. Both genomic, proteomic and phosphoproteomic profiling is performed. The proteomic and phosphoproteomic protocols use TMT-11 labeling for quantification. A total of 35 samples, originating from tumor biopsies from 14 patients from before and after treatment with trastuzumab in combination with pertuzumab and chemotherapy, were spread across 4 TMT plexes for analysis. Each plex, which also contains two common reference channels, was further divided into 24 fractions using basic phase reverse fractionation before proteomic data acquisition.

In this exercise, you will study a subset of the raw data. Specifically 1 fraction from 1 plex...


#Getting started on UCloud

For the purpose of this tutorial, the raw spectral data as well as the tools needed are available on the [UCloud](https://cloud.sdu.dk/) platform. To get started, switch to the "Proteomics sandbox" project in the dropdown box in the top of the page,

![Proteomics sandbox project](https://user-images.githubusercontent.com/3648982/141947252-6d3aa332-6e03-48a7-9aa0-b68f078665a9.png)

and find and click the "Proteomics Sandbox" app in the catalog:

![Proteomics Sandbox app](https://user-images.githubusercontent.com/3648982/141946651-1aaba841-bad2-4ace-89a1-04232bea5a75.png)

Before running the app, you need to change a number of settings to include the the needed folders with data and software and to run an initialization script to set up the software environment in the sandbox app. The easiest way to do that is to import a premade configuration file: Click "Import parameters" to the right, choose "Select file from UCloud" and find and select the file `Proteomics sandbox / App_launchers / ProteomicsSandbox.json`.

![import_appp configuration](https://user-images.githubusercontent.com/3648982/141950906-befda2a4-b712-4f8d-a5d0-256249eedb6d.png)

