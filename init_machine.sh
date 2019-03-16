#!/bin/sh

set -e

mkdir -p $HOME/Programs
mkdir -p $HOME/Development

export ROS_VERSION=melodic
export dl=$HOME/Downloads

add_repos () {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https software-properties-common
  
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

  sudo sh -c 'echo deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo add-apt-repository universe
}

install_from_deb() {
  wget -O ${dl}/gitkraken-amd64.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
  wget -O ${dl}/skypeforlinux-64.rpm https://go.skype.com/skypeforlinux-64.rpm
  wget -O ${dl}/franz_5.0.0_amd64.deb https://github.com/meetfranz/franz/releases/download/v5.0.0/franz_5.0.0_amd64.deb
  wget -O ${dl}/encryptr_2.0.0-1_amd64.deb https://spideroak.com/dist/encryptr/signed/linux/deb/encryptr_2.0.0-1_amd64.deb

  sudo apt-get update
  sudo apt-get install alien

  sudo dpkg -i ${dl}/gitkraken-amd64.deb 
  sudo dpkg -i ${dl}/franz_5.0.0_amd64.deb
  sudo dpkg -i ${dl}/encryptr_2.0.0-1_amd64.deb

  sudo alien ${dl}/skypeforlinux-64.rpm
  sudo dpkg -i ${dl}/skypeforlinux-64.deb
}

install_zsh_theme () {
  wget -O ~/.oh-my-zsh/themes/superkolo.zsh-theme https://raw.githubusercontent.com/Minipada/superkolo/master/superkolo.zsh-theme
}

install_jx () {
  mkdir -p ~/.jx/bin
  curl -L https://github.com/jenkins-x/jx/releases/download/v1.3.978/jx-linux-amd64.tar.gz | tar xzv -C ~/.jx/bin
}

install_minikube () {
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
  sudo mv minikube /usr/local/bin
}

install_docker() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
  sudo usermod -aG docker ${USER}
}

install_kops () {
  curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
  chmod +x ./kops
  sudo mv ./kops /usr/local/bin/
}

install_awless () {
  curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash
  sudo mv awless /usr/local/bin
}

packages=" \
  asciinema \
  bridge-utils \
  cpu-checker \
  gconf2 \
  ghex \
  gimp \
  gvfs-bin \
  jq \
  kubectl \
  libappindicator1 \
  libvirt-bin \
  nvidia-384 \
  okular \
  picocom \
  python-pip \
  python-rosinstall \
  qemu-kvm \
  ros-${ROS_VERSION}-desktop-full \
  spotify-client \
  terminator \
  virtinst \
  virtualbox \
  virtualbox-dkms \
  zsh
"

pip_packages=" \
  ansible \
  bloom \
  catkin-tools \
"

add_repos

sudo apt-get update
sudo apt-get install -y ${packages}
install_awless
install_docker
install_jx
install_kops
install_minikube
sudo pip install -U ${pip_packages}

install_from_deb

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
install_zsh_theme

cp .vimrc $HOME
cp .zshrc $HOME

kvm-ok