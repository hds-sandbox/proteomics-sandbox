# The Clinical Proteomics Sandbox

This repository is a collection of the material related to teaching clinical proteomics, which is divided into the following modules:

1. Identification
1. Quality Control
1. Bioinformatics
1. PhosphoProteomics

Each module has a corresponding subfolder with instructions, notebooks, and other materials for completing the course. Software and clinical datasets for the course can be found on [UCloud](cloud.sdu.dk) in the "Proteomics Sandbox" project.

## Sandbox app on UCloud

The [Proteomics Sandbox app](https://cloud.sdu.dk/app/applications/proteomics/Oct2021/) on [UCloud](https://cloud.sdu.dk/) can be used to complete some of the exercises in this repository, particularly those under the [01_Identification](01_Identification) module. Instructions for starting the app are provided in that section. If you already started the sandbox app, you may be seeing this page within the sandbox remote desktop session.

**Software**

Software pacakges are installed under `/work/SW` and can be started from desktop icons. The following software packages are available:

* [FragPipe](https://fragpipe.nesvilab.org/):
     * Automated peptide and protein identification and quantification using the MSFragger search engine.
     * Supports the identification of arbitrary PTMs.
     * Includes additional tools for post-processing and visualization of search results.
* [MaxQuant](https://www.maxquant.org/):
    * Comprehensive software suite for proteomics data analysis.
    * Includes protein and peptide identification, quantification, and visualization of spectral matches.
    * Features an advanced search engine and a user-friendly graphical interface.
* [PDV](https://www.maxquant.org/):
    * Visualization tool for spectral matches, particularly those obtained from MSFragger searches.
    * Allows users to inspect and evaluate the quality of the matches.
    * Supports annotation and customization of plots.
* [SearchGUI](http://compomics.github.io/projects/searchgui):
    * User-friendly interface for performing peptide searches using multiple search engines (e.g. MSFragger, X!Tandem, OMSSA).
    * Supports a wide range of search options and post-processing features.
* [PeptideShaker](http://compomics.github.io/projects/peptide-shaker#:~:text=PeptideShaker%20is%20a%20search%20engine,%2C%20Novor%2C%20DirecTag%20and%20mzIdentML.):
    * Tool for visualizing and analyzing the results of peptide searches performed with SearchGUI.
    * Includes features for filtering, annotation, and visualization of results.
    * Supports integration with other proteomics databases and software.

**Analyzing Datasets in the Proteomics Sandbox App**

In order to analyze the datasets, they must be placed in a folder where you have write access. However, making a full copy of a dataset to your own storage area can consume a large amount of space. The Proteomics Sandbox app offers a feature that allows you to create a lightweight clone of a folder structure, containing links to the original files instead of copies.
