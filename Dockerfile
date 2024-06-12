# Use Ubuntu as the base image
FROM dreg.cloud.sdu.dk/ucloud-apps/ubuntu:Apr2024-xfce

# Labels for the Dockerfile
LABEL software="Proteomics Sandbox"\
      author="Jacob Fredegaard Hansen  <jfredegaard@bmb.sdu.dk>"\
      version="v2024.06"\
      license="MIT"\
      description="Proteomics sandbox with software for clinical proteomics data analysis."

# Set the working directory
WORKDIR /opt

## Installing dependencies for proteomics sandbox app
# Update package list and install python3-pip
RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt-get install -y python3.9 python3.9-venv python3.9-dev python3-pip && \
    sudo apt-get install -y mono-devel && \  
    sudo apt install -y libgtk-3-dev && \
    sudo apt install -y wmctrl && \
    sudo apt-get purge -y -q firefox && \
    sudo apt-get install -y -q firefox && \
    sudo apt-get clean

#Installing pip for Python3.9
RUN sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py

# Add Microsoft package signing key, repository, and install libicu
RUN wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb && \
    sudo rm packages-microsoft-prod.deb && \
    sudo apt-get update && \
    wget http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu70_70.1-2_amd64.deb && \
    sudo dpkg -i libicu70_70.1-2_amd64.deb && \
    sudo rm libicu70_70.1-2_amd64.deb

# Install .NET Core SDK 7.0 and ASP.NET Core Runtime 7.0
RUN sudo apt-get update && \
    sudo apt-get install -y dotnet-sdk-7.0 aspnetcore-runtime-7.0 && \
    sudo apt-get clean

# Upgrade pip and setuptools to ensure we have the latest versions
# Install specific versions and latest versions of required Python packages: easypqp and lxml and numpy (already installed) and pandas in Python3.9 for FragPipe and attrdict3, gooey, pyinstaller for the DIA-NN GUI 
RUN sudo python3.9 -m pip install --upgrade pip setuptools && \
    sudo python3.9 -m pip install pyopenms==2.6.0 easypqp lxml attrdict3 gooey pyinstaller && \
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
    sudo unzip /usr/local/MSFragger-4.1.zip -d /usr/local && \
    sudo mv /usr/local/MSFragger-4.1 /opt/fragpipe/tools && \
    sudo unzip /usr/local/IonQuant-1.10.27.zip -d /usr/local && \
    sudo mv /usr/local/IonQuant-1.10.27 /opt/fragpipe/tools && \
    sudo unzip /usr/local/diaTracer-1.1.3.zip -d /usr/local && \
    sudo mv /usr/local/diaTracer-1.1.3 /opt/fragpipe/tools && \
    sudo mkdir /usr/local/ProteoWizard && \
    sudo tar xvjf /usr/local/pwiz-bin-linux-x86_64-gcc7-release-3_0_23007_23d2af0.tar.bz2 -C /usr/local/ProteoWizard && \
    sudo unzip /usr/local/MaxQuant_v2.5.2.0.zip -d /usr/local && \
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
    sudo wget https://github.com/Nesvilab/FragPipe/releases/download/22.0/FragPipe-22.0.zip && \
    sudo unzip FragPipe-22.0.zip && \
    sudo rm FragPipe-22.0.zip && \
    sudo wget https://github.com/Nesvilab/philosopher/releases/download/v5.1.0/philosopher_v5.1.0_linux_amd64.zip && \
    sudo unzip philosopher_v5.1.0_linux_amd64.zip && \
    sudo rm philosopher_v5.1.0_linux_amd64.zip && \
    sudo mv /opt/philosopher /opt/fragpipe/tools && \
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
    sudo cp /usr/share/applications/launchers/*.desktop ~/Desktop && \
    sudo chmod -R a+rwx ~/Desktop

# Change to /opt/fragpipe and create the 'updates' directory with superuser permissions
RUN cd /opt/fragpipe && \
    sudo mkdir updates

# Set ownership for all .desktop files
RUN sudo chown $USER:$USER ~/Desktop/*.desktop 

# Set permissions for .desktop files and update xfce-exe-checksum metadata
RUN chmod 775 "${HOME}"/Desktop/*.desktop \
    && for f in "${HOME}"/Desktop/*.desktop; do \
        dbus-launch gio set -t string "$f" metadata::xfce-exe-checksum "$(sha256sum $f | awk '{print $1}')"; \
    done

# Set the working directory
WORKDIR /work

# Run the Docker container locally. It can be accessed at localhost:6901
# docker run --rm -it -p 6901:6901 -e VNC_RESOLUTION=1920x1200 -e VNC_PW=vncpassword --name myimage myimage bash -c "vnc_startup.sh firefox https://github.com/hds-sandbox/proteomics-course"