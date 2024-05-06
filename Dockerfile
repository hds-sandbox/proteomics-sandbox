# Use Ubuntu as the base image
FROM dreg.cloud.sdu.dk/ucloud-apps/ubuntu:Apr2024-xfce

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
    #sudo python3.9 -m pip install attrdict3 gooey pyinstaller && \
    sudo apt-get install -y mono-devel && \  
    sudo apt install -y libgtk-3-dev && \
    sudo apt install -y wmctrl && \
    sudo apt-get purge -y -q firefox && \
    sudo apt-get install -y -q firefox && \
    sudo apt-get clean

#Installing pip for Python3.9
RUN sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py

# Install easypqp and lxml and numpy and pandas Python3.9 for FragPipe and attrdict3, gooey, pyinstaller for the DIA-NN GUI 
RUN sudo python3.9 -m pip install --upgrade pip setuptools
RUN sudo python3.9 -m pip install pyopenms==2.6.0 
RUN sudo python3.9 -m pip install easypqp
RUN sudo python3.9 -m pip install lxml
RUN sudo python3.9 -m pip install --force numpy pandas

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
    sudo unzip /usr/local/MSFragger-4.0.zip -d /usr/local && \
    sudo unzip /usr/local/IonQuant-1.10.12.zip -d /usr/local && \
    sudo mkdir /usr/local/ProteoWizard && \
    sudo tar xvjf /usr/local/pwiz-bin-linux-x86_64-gcc7-release-3_0_23007_23d2af0.tar.bz2 -C /usr/local/ProteoWizard && \
    sudo unzip /usr/local/MaxQuant_2.4.3.0 -d /usr/local && \
    sudo mv /usr/local/'MaxQuant 2.4.3.0' /usr/local/MaxQuant-2.4.3.0 && \
    #sudo mkdir /usr/local/vmd-1.9.3 && \
    sudo tar xvzf /usr/local/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz -C /usr/local && \
    sudo rm /usr/local/*.tar.gz && \
    sudo rm /usr/local/*.zip && \
    sudo rm /usr/local/*.tar.bz2

# Configure and install vmd
WORKDIR /usr/local/vmd-1.9.3
RUN sudo ./configure && \
    cd src/ && \
    sudo make install && \
    cd /usr/local
    #sudo rm -rf vmd-1.9.3

# Set the working directory
WORKDIR /opt

## Installing software for the proteomics sandbox app
# Install SearchGUI, FragPipe, Philosopher, PDV, PeptideShaker, ThermoRawFileParserGUI, and DIA-NN
RUN sudo wget https://genesis.ugent.be/maven2/eu/isas/searchgui/SearchGUI/4.3.9/SearchGUI-4.3.9-mac_and_linux.tar.gz && \
    sudo tar -xzf SearchGUI-4.3.9-mac_and_linux.tar.gz && \
    sudo rm SearchGUI-4.3.9-mac_and_linux.tar.gz && \
    sudo wget https://github.com/Nesvilab/FragPipe/releases/download/21.1/FragPipe-21.1.zip && \
    sudo unzip FragPipe-21.1.zip && \
    sudo rm FragPipe-21.1.zip && \
    sudo wget https://github.com/Nesvilab/philosopher/releases/download/v5.1.0/philosopher_v5.1.0_linux_amd64.zip && \
    sudo unzip philosopher_v5.1.0_linux_amd64.zip && \
    sudo rm philosopher_v5.1.0_linux_amd64.zip && \
    sudo wget https://github.com/wenbostar/PDV/releases/download/v2.0.0/PDV-2.0.0.zip && \
    sudo unzip PDV-2.0.0.zip && \
    sudo rm PDV-2.0.0.zip && \
    sudo wget https://genesis.ugent.be/maven2/eu/isas/peptideshaker/PeptideShaker/3.0.8/PeptideShaker-3.0.8.zip && \
    sudo unzip PeptideShaker-3.0.8.zip && \
    sudo rm PeptideShaker-3.0.8.zip && \
    sudo wget https://genesis.ugent.be/maven2/no/uib/thermo-raw-file-parser-gui/ThermoRawFileParserGUI/1.7.3/ThermoRawFileParserGUI-1.7.3.zip && \
    sudo unzip ThermoRawFileParserGUI-1.7.3.zip && \
    sudo rm ThermoRawFileParserGUI-1.7.3.zip && \
    sudo wget https://github.com/mzmine/mzmine3/releases/download/v4.0.3/mzmine-linux-installer_4.0.3.deb && \
    sudo apt-get install -y ./mzmine-linux-installer_4.0.3.deb && \
    sudo rm mzmine-linux-installer_4.0.3.deb

# Set permissions and configurations
 RUN sudo chmod -R a+rwx /opt/SearchGUI-4.3.9/resources && \
    sudo chmod -R a+rwx /opt/PeptideShaker-3.0.8/resources && \
    # sudo chmod -R a+rwx /opt/fragpipe && \
    sudo cp /usr/share/applications/launchers/*.desktop ~/Desktop && \
    sudo chmod -R a+rwx ~/Desktop

# Set ownership for all .desktop files
RUN sudo chown $USER:$USER ~/Desktop/*.desktop 
    #sudo gio set ~/Desktop/*.desktop "metadata::trusted" yes

# Modify .desktop files to set the trusted metadata attribute
#RUN sudo sed -i 's/^\[Desktop Entry\]$/&\nmetadata::trusted=true/' /home/user/Desktop/*.desktop

# Set the working directory
WORKDIR /work

# Run the Docker container locally. It can be accessed at localhost:6901
# docker run --rm -it -p 6901:6901 -e VNC_RESOLUTION=1920x1200 -e VNC_PW=vncpassword --name myimage myimage bash -c "vnc_startup.sh firefox https://github.com/hds-sandbox/proteomics-course"
