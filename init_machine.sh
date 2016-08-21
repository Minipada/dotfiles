#Init folders
mkdir -p $HOME/Programs
mkdir -p $HOME/Development
mkdir -p $HOME/Desktop/deb
mkdir -p $HOME/pdf
mkdir -p $HOME/pem
mkdir -p $HOME/scripts
mkdir -p $HOME/sd-img

#Chrome
CHROME="google-chrome-stable"

#GHEX
GHEX="ghex"

#GIMP
GIMP="gimp"

#GIT KRAKEN
wget -P $HOME/Desktop/deb https://www.gitkraken.com/download/linux-deb

#LATEX
LATEX="texlive-full"

#OKULAR
OKULAR="okular"

#PICOCOM
PICOCOM="picocom"

#PYCHARM
PYCHARM_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=linux&code=PCC"
tar -C $HOME/Programs -zxvf pycharm-community-2016.*.tar.gz
rm pycharm-community-2016.*.tar.gz

#QTCREATOR
QTCREATOR_URL="curl -s "https://www.qt.io/download-open-source/#section-2" | \
  grep -o '<a target=\"_blank\" href=['"'"'"][^"'"'"']*['"'"'"]' | \
  grep -m 1 opensource-linux-x64-'[0-9]'.\*.run\" | \
  sed -e 's/^<a target=\"_blank\" href=["'"'"']//' -e 's/["'"'"']$//'"
wget -P $HOME/Programs $QTCREATOR_URL

#ROS
ROS_VERSION="kinetic"
ROS="ros-$ROS_VERSION-desktop-full \
  python-rosinstall \
  ros-kinetic-xacro \
  ros-kinetic-joy \
  ros-kinetic-gazebo-ros \
  ros-kinetic-pcl-ros \
  ros-kinetic-rosserial \
  ros-kinetic-stage \
  ros-kinetic-turtlebot \
  ros-kinetic-turtlebot-gazebo \
  ros-kinetic-turtlebot-teleop \
  ros-kinetic-turtlebot-navigation \
  ros-kinetic-opencv3 \
  ros-kinetic-p2os-urdf \
  "

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

#SKYPE
SKYPE="skype"

#SPOTIFY
# 1. Add the Spotify repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

SPOTIFY="spotify-client"

#SUBLIME
sudo add-apt-repository ppa:webupd8team/sublime-text-2
SUBLIME="sublime-text"

#TERMINATOR
TERMINATOR="terminator"

#VLC
VLC="vlc"

#ZSH
ZSH="zsh"

PACKAGES="$CHROME \
  $GHEX \
  $GIMP \
  $LATEX \
  $OKULAR \
  $PICOCOM \
  $ROS \
  $SKYPE \
  $SPOTIFY \
  $SUBLIME \
  $TERMINATOR \
  $VLC \
  $ZSH \
  "

sudo apt-get update
sudo apt-get install "$PACKAGES"

#After everything is set
#install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh

#Install Git kraken
sudo dpkg -i $HOME/Desktop/deb/gitkraken-amd64.deb

#Install Qtcreator
chmod +x $HOME/Programs/qt-opensource.*
$HOME/Programs/./qt-opensource.*.run
