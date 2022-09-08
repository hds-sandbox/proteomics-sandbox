# The Clinical Proteomics Sandbox

This repository is used to collect the material related to teaching clinical proteomics. The material is divided into a number of modules:

1. Identification
1. Quality Control
1. Bioinformatics
1. PhosphoProteomics

The corresponding subfolders contain the instructions, notebooks and other materials needed to complete the "course". Software and clinical datasets are available on [UCloud](cloud.sdu.dk) in the project "Proteomics Sandbox".

## Sandbox app on UCloud

The [Proteomics Sandbox app](https://cloud.sdu.dk/app/applications/proteomics/Oct2021/) on [UCloud](https://cloud.sdu.dk/) can be used for going through some of the exercises described in this repoitory - particularly the exercises under [01_Identification](01_Identification). Instructions for starting the app are provided in that section. If you already started the sandbox app, you may be seeing this page within the sandbox remote desktop session. Within the app, you will have access to a number of resources, described below:

**Folder structure**

The following paths are available

* `/ucloud`: Your home directory. Any files stored here will be lost, when the app is stopped.
* `/work/SW`: Installed proteomics software is available here (see below)
* `/work/Data`: Example datasets (see below)
* `/work/ProteomicsWork`: Working directory stored under your own "My Workspace" project in UCloud
* `/work`: Anything else stored under /work will be available under the "Jobs" folder in UCloud

**Software**

Software pacakges are installed under `/work/SW` and can be started from desktop icons. The following software packages are available:

* FragPipe: Wrapper for the MSFragger search engine and accompanying tools for protein/peptide identification and quantification. Supports open search for arbitrary PTM identification.
* MaxQuant: Advanced search engine and GUI protein/peptide identification and quantification as well as visualization of spectra and spectral matches.
* PDV: Visualization of spectral matches, e.g. from MSFragger
* SearchGUI: Simple interface for peptide search using a number of different search engines
* PeptideShaker: Visualization of spectral matches from SearchGUI

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

In order to analyse the datasets, they need to be located in a folder, where you have write access. However, making a full copy of a dataset to your own storage area can take up a lot of space. The Proteomics Sandbox app has a feature to make a light-weight clone of a folder structure, containing links to the original files instead of copies. See the instructions under [01_Identification](01_Identification) for further details.

