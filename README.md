# The Proteomics Sandbox App
The [Proteomics Sandbox App](https://cloud.sdu.dk/app/jobs/create?app=proteomics&version=Mar2023) is an excellent resource for biomedical students and non-computational researchers to learn and apply clinical proteomics at [UCloud](https://cloud.sdu.dk/). It provides a stable platform for proteomics software tools and offers a user-friendly interface. It is easy to use and does not require extensive coding knowledge. Furthermore, the app's lightweight clone feature optimizes storage requirements when working with datasets.

## **Software**  
The software available in the Proteomics Sandbox includes FragPipe, MaxQuant, PDV, SearchGUI, ThermoRawFileParser, and PeptideShaker. These software tools provide automated peptide and protein identification and quantification, comprehensive proteomics data analysis, visualization tools for spectral matches, a user-friendly interface for performing peptide searches, and a tool for visualizing and analyzing peptide search results. A list of the available software and its functionalities is listed below:

* [FragPipe](https://fragpipe.nesvilab.org/):
     * Automated peptide and protein identification and quantification using the MSFragger search engine.
     * Supports the identification of arbitrary PTMs.
     * Includes additional tools for post-processing and visualization of search results.
* [MaxQuant](https://www.maxquant.org/):
    * Comprehensive software suite for proteomics data analysis.
    * Includes protein and peptide identification, quantification, and visualization of spectral matches.
    * Features an advanced search engine; only the command-line tool is available on Linux as the GUI is incompatible. Read more [here](https://cox-labs.github.io/coxdocs/Download_Installation.html).
    * MaxQuant is located in `/usr/local/bin/MaxQuant_v2.5.2.0`.
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
* [MZmine 3](https://mzmine.github.io/):
    * Open-source software specialized for mass-spectrometry data processing, with an emphasis on LC-MS data.
    * Based on the original MZmine toolbox, but has undergone comprehensive redesign and rewriting.
    * Offers a user-friendly, adaptable, and expandable platform.
    * Provides a complete set of modules addressing the entire LC-MS data analysis workflow.
* [DIA-NN](https://github.com/vdemichev/DiaNN):
    * Universal software for DIA proteomics data processing, revolutionizing proteomics in 2018 with innovative algorithms.
    * Focuses on reliability, robustness, and reproducibility with stringent statistical control, flexible data modeling, and meticulous recording of all analysis steps.
    * User-friendly with a high degree of automation, no bioinformatics expertise required, and showcases scalability by processing up to 1000 mass spec runs per hour.
    * The newly developed GUI for Linux further enhances the user-friendliness for Proteomics Sandbox App users, making DIA-NN even more accessible.
* [VMD](https://www.ks.uiuc.edu/Research/vmd/):
    * High-performance molecular visualization program for displaying, animating, and analyzing large biomolecular systems.
    * Facilitates the examination of protein structures and interactions derived from PDB files, offering advanced visualization capabilities.


 
## **Analyzing Datasets in the Proteomics Sandbox App**  
In order to analyze the datasets, they must be placed in a folder where you have write access. However, making a full copy of a dataset to your own storage area can consume a large amount of space. The Proteomics Sandbox app offers a feature that allows you to create a lightweight clone of a folder structure, containing links to the original files instead of copies located in the `work` directory.
