#!/bin/bash 

#vert.x
if [ ! -f /usr/local/bin/vert.x-1.3.1.final/bin/vertx ]
	then
		wget http://vert-x.github.io/vertx-downloads/downloads/vert.x-1.3.1.final.tar.gz
		gunzip vert.x-1.3.1.final.tar.gz 
		tar xvf vert.x-1.3.1.final.tar
		sudo mv vert.x-1.3.1.final /usr/local/bin/
		rm vert.x*
		CONFIG_VERTX=0
	else
		echo "vert.x already installed, skipping..."
fi


# java 7
apt-get update
sudo apt-get install -y openjdk-7-jdk

#jRuby
if [ ! -f /usr/local/bin/jruby-1.7.4/bin/jruby ]
	then
		wget http://jruby.org.s3.amazonaws.com/downloads/1.7.4/jruby-bin-1.7.4.tar.gz
		gunzip jruby-bin-1.7.4.tar.gz
		tar xvf jruby-bin-1.7.4.tar
		sudo mv jruby-1.7.4 /usr/local/bin/
		CONFIG_JRUBY=0
	else
		echo "jRuby already installed, skipping"
fi

# set required paths
if [ $CONFIG_JRUBY ]
	then
		echo "export JRUBY_HOME='/usr/local/bin/jruby-1.7.4'" >> /home/vagrant/.profile
		echo 'PATH="/usr/local/bin/jruby-1.7.4/bin:$PATH"' >> /home/vagrant/.profile
		# vert.x dependency
		sudo /usr/local/bin/jruby-1.7.4/bin/jruby -S gem install json
fi
if [ $CONFIG_VERTX ]
	then
		echo 'PATH="/usr/local/bin/vert.x-1.3.1.final/bin:$PATH"' >> /home/vagrant/.profile
fi


sudo apt-get install -y git
