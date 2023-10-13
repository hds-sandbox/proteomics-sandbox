# Use Ubuntu 22.04 as the base image
FROM dreg.cloud.sdu.dk/ucloud-apps/ubuntu-xfce:22.04

# Labels for the Dockerfile
LABEL software="Proteomics Sandbox"\
      author="Jacob Fredegaard Hansen  <jfredegaard@bmb.sdu.dk>"\
      version="v2023.10"\
      license="MIT"\
      description="Proteomics sandbox with software for clinical proteomics data analysis."

# Set the working directory
WORKDIR /opt

## Installing dependencies for proteomics sandbox app
# Update package list and install wget, unzip, python3-pip
RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt-get install -y python3.9 python3.9-venv python3.9-dev python3-pip && \
    sudo apt-get install -y mono-devel && \ 
    sudo pip install attrdict3 gooey pyinstaller && \ 
    sudo apt install -y libgtk-3-dev && \
    sudo apt install -y wmctrl && \
    sudo apt-get purge -y -q firefox && \
    sudo apt-get install -y -q firefox && \
    sudo apt-get clean

#Installing pip for Python3.9
RUN sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py

# Install easypqp and lxml and numpy and pandas Python3.9 for FragPipe
RUN sudo python3.9 -m pip install pyopenms==2.6.0 easypqp lxml && \
    sudo python3.9 -m pip install --force numpy pandas

# Create the /usr/local directory in the container
RUN mkdir -p /usr/local

# Copy necessary files
COPY ./Installers /usr/local
COPY ./Scripts/ /opt
COPY ./cache.template /opt/fragpipe/cache
COPY ./launchers /usr/share/applications/launchers

# Unzip, install, and cleanup
RUN sudo chmod +x /opt/diann_install.sh && \
    /opt/diann_install.sh && \
    sudo rm /opt/diann_install.sh && \
    sudo rm /opt/install_gooey.sh && \
    sudo unzip /usr/local/MSFragger-3.8.zip -d /usr/local && \
    sudo unzip /usr/local/IonQuant-1.9.8.zip -d /usr/local && \
    sudo mkdir /usr/local/ProteoWizard && \
    sudo tar xvjf /usr/local/pwiz-bin-linux-x86_64-gcc7-release-3_0_23007_23d2af0.tar.bz2 -C /usr/local/ProteoWizard && \
    sudo unzip /usr/local/MaxQuant_2.4.3.0 -d /usr/local && \
    sudo mv /usr/local/'MaxQuant 2.4.3.0' /usr/local/MaxQuant-2.4.3.0 && \
    sudo rm /usr/local/*.zip && \
    sudo rm /usr/local/*.tar.bz2

## Installing software for the proteomics sandbox app
# Install SearchGUI, FragPipe, Philosopher, PDV, PeptideShaker, ThermoRawFileParserGUI, and DIA-NN
RUN sudo wget https://genesis.ugent.be/maven2/eu/isas/searchgui/SearchGUI/4.3.1/SearchGUI-4.3.1-mac_and_linux.tar.gz && \
    sudo tar -xzf SearchGUI-4.3.1-mac_and_linux.tar.gz && \
    sudo rm SearchGUI-4.3.1-mac_and_linux.tar.gz && \
    sudo wget https://github.com/Nesvilab/FragPipe/releases/download/20.0/FragPipe-20.0.zip && \
    sudo unzip FragPipe-20.0.zip && \
    sudo rm FragPipe-20.0.zip && \
    sudo wget https://github.com/Nesvilab/philosopher/releases/download/v5.0.0/philosopher_v5.0.0_linux_amd64.zip && \
    sudo unzip philosopher_v5.0.0_linux_amd64.zip && \
    sudo rm philosopher_v5.0.0_linux_amd64.zip && \
    sudo wget https://github.com/wenbostar/PDV/releases/download/v1.8.1/PDV-1.8.1.zip && \
    sudo unzip PDV-1.8.1.zip && \
    sudo rm PDV-1.8.1.zip && \
    sudo wget https://genesis.ugent.be/maven2/eu/isas/peptideshaker/PeptideShaker/3.0.1/PeptideShaker-3.0.1.zip && \
    sudo unzip PeptideShaker-3.0.1.zip && \
    sudo rm PeptideShaker-3.0.1.zip && \
    sudo wget https://genesis.ugent.be/maven2/no/uib/thermo-raw-file-parser-gui/ThermoRawFileParserGUI/1.7.3/ThermoRawFileParserGUI-1.7.3.zip && \
    sudo unzip ThermoRawFileParserGUI-1.7.3.zip && \
    sudo rm ThermoRawFileParserGUI-1.7.3.zip && \
    sudo wget https://github.com/mzmine/mzmine3/releases/download/v3.9.0/mzmine-linux-installer_3.9.0.deb && \
    sudo apt-get install -y ./mzmine-linux-installer_3.9.0.deb && \
    sudo rm mzmine-linux-installer_3.9.0.deb

# Set permissions and configurations
RUN sudo chmod -R a+rwx /opt/SearchGUI-4.3.1/resources && \
    sudo chmod -R a+rwx /opt/PeptideShaker-3.0.1/resources && \
    sudo cp /usr/share/applications/launchers/*.desktop /ucloud/Desktop && \
    sudo chmod -R a+rwx /ucloud/Desktop

# Set the working directory
WORKDIR /work

# Run the Docker container locally. It can be accessed at localhost:6901
# docker run --rm -it -p 6901:6901 -e VNC_RESOLUTION=1920x1200 -e VNC_PW=vncpassword --name myimage myimage bash -c "vnc_startup.sh firefox https://github.com/hds-sandbox/proteomics-course"