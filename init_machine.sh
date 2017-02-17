#Init folders
mkdir -p $HOME/Programs
mkdir -p $HOME/Development
mkdir -p $HOME/Desktop/deb
mkdir -p $HOME/Desktop/pdf
mkdir -p $HOME/Desktop/pem
mkdir -p $HOME/Desktop/scripts
mkdir -p $HOME/Desktop/sd-img

#BOOST
BOOST_VERSION_MAIN="1"
BOOST_VERSION_SUB="58"
OUTPUT_BOOST_TAR="boost_$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB.tar.gz"
OUTPUT_BOOST="boost_$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB"
wget --output-document=$OUTPUT_BOOST https://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB.0/boost_$BOOST_VERSION_MAIN\_$BOOST_VERSION_SUB\_0.tar.gz/download
tar -xzvf $OUTPUT_BOOST
cd $OUTPUT_BOOST
./bootstrap.sh --libdir=/usr/lib/x86_64-linux-gnu
./b2
sudo ./b2 install
rm -rf $OUTPUT_BOOST

#Chrome
CHROME="google-chrome-stable"

#GHEX
GHEX="ghex"

#GIMP
GIMP="gimp"

#GIT KRAKEN
wget -P $HOME/Desktop/deb https://www.gitkraken.com/download/linux-deb

#JQ
JQ="jq"

#LATEX
LATEX="texlive-full"

#MAID
MAID="maid"

#NPM
NPM="npm"

#OKULAR
OKULAR="okular"

#PICOCOM
PICOCOM="picocom"

#PYCHARM
PYCHARM_URL="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=linux&code=PCC"
tar -C $HOME/Programs -zxvf pycharm-community-2016.*.tar.gz
rm pycharm-community-2016.*.tar.gz

#QTCREATOR
QTCRATOR_URL=$(curl -s "https://www.qt.io/download-open-source/#section-2" | \
  grep -o '<a target=\"_blank\" href=['"'"'"][^"'"'"']*['"'"'"]' | \
  grep -m 1 opensource-linux-x64-'[0-9]'.\*.run\" | \
  sed -e 's/^<a target=\"_blank\" href=["'"'"']//' -e 's/["'"'"']$//'"""")
wget -P $HOME/Programs $QTCREATOR_URL
cd $HOME/Programs
echo "Install in \"Qt\" folder, not QTX.X.X"
./$(basename QTCREATOR_URL)

#ROS
ROS_VERSION="kinetic"
ROS="ros-$ROS_VERSION-desktop-full \
  python-rosinstall \
  ros-$ROS_VERSION-xacro \
  ros-$ROS_VERSION-joy \
  ros-$ROS_VERSION-gazebo-ros \
  ros-$ROS_VERSION-pcl-ros \
  ros-$ROS_VERSION-rosserial \
  ros-$ROS_VERSION-stage \
  ros-$ROS_VERSION-turtlebot \
  ros-$ROS_VERSION-turtlebot-gazebo \
  ros-$ROS_VERSION-turtlebot-teleop \
  ros-$ROS_VERSION-turtlebot-navigation \
  ros-$ROS_VERSION-opencv3 \
  ros-$ROS_VERSION-p2os-urdf \
  ros-$ROS_VERSION-robot-localization \
  ros-$ROS_VERSION-joy \
  ros-$ROS_VERSION-costmap-2d \
  ros-$ROS_VERSION-amcl \
  ros-$ROS_VERSION-control-toolbox \
  ros-$ROS_VERSION-move-base \
  ros-$ROS_VERSION-hector-gazebo-plugins \
  ros-$ROS_VERSION-map-server \
  ros-$ROS_VERSION-turtlebot-stage \
  ros-$ROS_VERSION-ros-control \
  ros-$ROS_VERSION-gazebo-ros-control \
  ros-$ROS_VERSION-joint-state-controller \
  ros-$ROS_VERSION-effort-controllers \
  ros-$ROS_VERSION-joint-trajectory-controller \
  ros-$ROS_VERSION-object-recognition-* \
"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

#RUBY - needed for maid
RUBY="ruby"

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
  $JQ \
  $GHEX \
  $GIMP \
  $LATEX \
	$NPM \
  $OKULAR \
  $PICOCOM \
  $ROS \
  $RUBY \
  $SKYPE \
  $SPOTIFY \
  $SUBLIME \
  $TERMINATOR \
  $VLC \
  $ZSH \
  "

sudo apt-get update
sudo apt-get install "$PACKAGES"

#diff-so-fancy
npm install -g diff-so-fancy

#After everything is set
#install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh

#Install QTCREATOR ROS PLUGIN
cd $HOME/Programs/Qt
git clone --recursive -b master https://github.com/ros-industrial/ros_qtc_plugin
cd ros_qtc_plugin
bash setup.sh -d

#Install Git kraken
sudo dpkg -i $HOME/Desktop/deb/gitkraken-amd64.deb

#Install Qtcreator
chmod +x $HOME/Programs/qt-opensource.*
$HOME/Programs/./qt-opensource.*.run

#Install yaml-cpp library
git clone https://github.com/jbeder/yaml-cpp
cd yaml-cpp
mkdir build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
cd ../..
rm -rf yaml-cpp

#Install maid
gem install $MAID

#Install dotfiles
cp .vimrc $HOME
cp .zshrc $HOME
cp rules.rb $HOME/.maid
