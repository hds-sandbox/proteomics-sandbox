# The Clinical Proteomics Sandbox

This repository is a collection of the material related to teaching clinical proteomics, which is divided into the following modules:

1. Identification
1. Quality Control
1. Bioinformatics
1. PhosphoProteomics

Each module has a corresponding subfolder with instructions, notebooks, and other materials for completing the course. Software and clinical datasets for the course can be found on [UCloud](cloud.sdu.dk) in the "Proteomics Sandbox" project.

## Sandbox app on UCloud

The [Proteomics Sandbox app](https://cloud.sdu.dk/app/applications/proteomics/Oct2021/) on [UCloud](https://cloud.sdu.dk/) can be used to complete some of the exercises in this repository, particularly those under the [01_Identification](01_Identification) module. Instructions for starting the app are provided in that section. If you already started the sandbox app, you may be seeing this page within the sandbox remote desktop session. The app provides access to the following resources:

**Folder structure**

The following paths are available

* `/ucloud`: Your home directory. Any files stored here will be lost, when the app is stopped.
* `/work/SW`: Installed proteomics software is available here (see below)
* `/work/Data`: Example datasets (see below)
* `/work/ProteomicsWork`: Working directory stored under your own "My Workspace" project in UCloud
* `/work`: Anything else stored under /work will be available under the "Jobs" folder in UCloud

**Software**

Software pacakges are installed under `/work/SW` and can be started from desktop icons. The following software packages are available:

* FragPipe:
 * Automated peptide and protein identification and quantification using the MSFragger search engine.
 * Supports the identification of arbitrary PTMs.
 * Includes additional tools for post-processing and visualization of search results.
* MaxQuant:
Comprehensive software suite for proteomics data analysis.
Includes protein and peptide identification, quantification, and visualization of spectral matches.
Features an advanced search engine and a user-friendly graphical interface.
* PDV:
Visualization tool for spectral matches, particularly those obtained from MSFragger searches.
Allows users to inspect and evaluate the quality of the matches.
Supports annotation and customization of plots.
* SearchGUI:
User-friendly interface for performing peptide searches using multiple search engines (e.g. MSFragger, X!Tandem, OMSSA).
Supports a wide range of search options and post-processing features.
* PeptideShaker:
Tool for visualizing and analyzing the results of peptide searches performed with SearchGUI.
Includes features for filtering, annotation, and visualization of results.
Supports integration with other proteomics databases and software.


**Data**

A number of clinical datasets from two different studies are included under `/work/Data`:
Datasets currently available in the UCloud project are highlighted in **bold**.

* CPTAC GBM Discovery Study (glioblastoma study)
  * Large cohort study (99 patients) charting the proteogenome of tumor samples.
  * [Wang, L.B, Karpova, A., et al. Cancer Cell 39(4):509-528 (2021)](https://www.cell.com/cancer-cell/fulltext/S1535-6108(21)00050-7)
  * TMT-11 data
  * Lots of metadata (in supplementary material)
  * PDC000203: CompRef Proteome
  * **PDC000204: Proteome**
  * PDC000205: Phosphoproteome
  * PDC000206: CompRef Phosphoproteome
  * PDC000245: Acetylome
  * PDC000246: CompRef Acetylome

* Microscaled Proteogenomic Methods for Precision Oncology
  * Breast cancer tumors analyzed using traditional CPTAC (bulk) and new proposed microscaled (needle core) protocols. 14 patient clinical trial + mouse (PDX) study.
  * TMT-10/11 data
  * **PDC000325: DP1 Clinical Trial - Proteome**
  * **PDC000326: DP1 Clinical Trial - Phosphoproteome**
  * **PDC000327: PDX bulk - Proteome**
  * PDC000328: PDX bulk - Phosphoproteome
  * **PDC000329: PDX cores - Proteome**
  * PDC000330: PDX cores - Phosphoproteome

**Analyzing Datasets in the Proteomics Sandbox App**

In order to analyze the datasets, they must be placed in a folder where you have write access. However, making a full copy of a dataset to your own storage area can consume a large amount of space. The Proteomics Sandbox app offers a feature that allows you to create a lightweight clone of a folder structure, containing links to the original files instead of copies. Refer to the instructions under the [01_Identification](01_Identification) module for more information.
