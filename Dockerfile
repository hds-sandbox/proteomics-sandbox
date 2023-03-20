# Use Ubuntu 22.04 as the base image
FROM dreg.cloud.sdu.dk/ucloud-apps/ubuntu-xfce:22.04

# Labels for the Dockerfile
LABEL software="Proteomics Sandbox"\
      author="Jacob Fredegaard Hansen  <jfredegaard@bmb.sdu.dk>"\
      version="v2023.03"\
      license="MIT"\
      description="Proteomics sandbox with software and data for clinical proteomics data analysis."

# Set the working directory
WORKDIR /opt

## Installing dependencies for proteomics sandbox app
# Update package list and install wget, unzip, python3-pip
RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt-get install -y python3.9 python3.9-venv python3.9-dev && \
    sudo apt-get install -y mono-devel && \ 
    sudo apt-get clean


#Installing pip for Python3.9
RUN sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py

# Install easypqp and lxml for FragPipe
RUN sudo python3.9 -m pip install pyopenms==2.6.0 easypqp lxml

# Create the /usr/local directory in the container
RUN mkdir -p /usr/local

# Copy the contents of the host directory "./Installers" to the "/usr/local" directory in the container
COPY ./Installers /usr/local

## Unzip the necessary files, that needs registrition before it can be downloaded, and extract the contents to the /usr/local directory
# Unzip MSFragger-3.7.zip, IonQuant-1.8.10.zip, the installer file for ProteoWizard, and MaxQuant_v2.2.0.0.zip
RUN sudo unzip /usr/local/MSFragger-3.7.zip -d /usr/local && \
    sudo rm /usr/local/MSFragger-3.7.zip && \
    sudo unzip /usr/local/IonQuant-1.8.10.zip -d /usr/local && \
    sudo rm /usr/local/IonQuant-1.8.10.zip && \
    sudo tar xvjf /usr/local/pwiz-bin-linux-x86_64-gcc7-release-3_0_23007_23d2af0.tar.bz2 -C /usr/local && \
    sudo rm /usr/local/pwiz-bin-linux-x86_64-gcc7-release-3_0_23007_23d2af0.tar.bz2 && \
    sudo unzip /usr/local/MaxQuant_v2.2.0.0.zip -d /usr/local && \
    sudo rm /usr/local/MaxQuant_v2.2.0.0.zip

## Installing software for the proteomics sandbox app
# Install SearchGUI, FragPipe, Philosopher, PDV, PeptideShaker, and ThermoRawFileParserGUI
RUN wget https://genesis.ugent.be/maven2/eu/isas/searchgui/SearchGUI/4.2.7/SearchGUI-4.2.7-mac_and_linux.tar.gz && \
    tar -xzf SearchGUI-4.2.7-mac_and_linux.tar.gz && \
    rm SearchGUI-4.2.7-mac_and_linux.tar.gz && \
    wget https://github.com/Nesvilab/FragPipe/releases/download/19.1/FragPipe-19.1.zip && \
    unzip FragPipe-19.1.zip && \
    rm FragPipe-19.1.zip && \
    wget https://github.com/Nesvilab/philosopher/releases/download/v4.7.0/philosopher_v4.7.0_linux_amd64.zip && \
    unzip philosopher_v4.7.0_linux_amd64.zip && \
    rm philosopher_v4.7.0_linux_amd64.zip && \
    wget https://github.com/wenbostar/PDV/releases/download/v1.7.4/PDV-1.7.4.zip && \
    unzip PDV-1.7.4.zip && \
    rm PDV-1.7.4.zip && \
    wget https://genesis.ugent.be/maven2/eu/isas/peptideshaker/PeptideShaker/2.2.22/PeptideShaker-2.2.22.zip && \
    unzip PeptideShaker-2.2.22.zip && \
    rm PeptideShaker-2.2.22.zip && \
    wget https://genesis.ugent.be/maven2/no/uib/thermo-raw-file-parser-gui/ThermoRawFileParserGUI/1.7.2/ThermoRawFileParserGUI-1.7.2.zip && \
    unzip ThermoRawFileParserGUI-1.7.2.zip && \
    rm ThermoRawFileParserGUI-1.7.2.zip

# Configure cache for FragPipe
COPY ./cache.template /opt/fragpipe/cache

# Copy desktop icons to Ubuntu
COPY ./launchers /usr/share/applications/launchers
RUN cp /usr/share/applications/launchers/*.desktop /ucloud/Desktop

# Set the working directory
WORKDIR /work

# Run the Docker container locally. It can be accessed at localhost:6901
# docker run --rm -it -p 6901:6901 -e VNC_RESOLUTION=1920x1200 -e VNC_PW=vncpassword --name myimage myimage bash -c "vnc_startup.sh firefox https://github.com/hds-sandbox/proteomics-course"