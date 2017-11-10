
#Steps to install Hadoop 2.x
#Let's launch a ubuntu machine in AWS or you can use a local machine if you have one

sudo apt-get update

#
#ADD JAVA REPO
#
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update
sudo apt-get install -y oracle-java8-installer


echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc

#
#INSTALL SSH SERVER
#
sudo apt-get install -y openssh-server

#
#ENABLE SSH FOR PASSWORD BASED AUTHENTICATION
#

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service ssh restart


#
#CREATE A DEDICATED FOLDER FOR HADOOP ECOSYSTEM
#
sudo mkdir /bigdata
sudo chown -R <username>:<username> /bigdata


#
#GENERATE SSH KEYS AND AUTHENTICATE THEM
#
echo | ssh-keygen -P ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys


cd /bigdata


Download the Hadoop 2 setup
wget http://mirror.fibergrid.in/apache/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz

# http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz
# if this link does not work, get the latest active mirror link from apache hadoop website

#
#Extract it and rename folder
#
tar -zxvf hadoop-2.7.2.tar.gz
mv hadoop-2.7.2 hadoop

#
#navigate to configuration folder - etc/hadoop in hadoop dir
#
cd /bigdata/hadoop/etc/hadoop

wget -O core-site.xml http://viveknk.com/hadoop2/conf/core-site
wget -O mapred-site.xml http://viveknk.com/hadoop2/conf/mapred-site
wget -O hdfs-site.xml http://viveknk.com/hadoop2/conf/hdfs-site
wget -O yarn-site.xml http://viveknk.com/hadoop2/conf/yarn-site

wget -O ex.sh http://viveknk.com/hadoop2/conf/yarn-env
echo -e "\n\n" >> ex.sh
cat yarn-env.sh >> ex.sh
cat ex.sh > yarn-env.sh
rm ex.sh

cd /bigdata/hadoop/libexec

echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> ex.sh
echo -e "\n\n" >> ex.sh
cat hadoop-config.sh >> ex.sh
cat ex.sh > hadoop-config.sh
rm ex.sh



echo "export PATH=$PATH:/bigdata/hadoop/sbin:/bigdata/hadoop/bin:/bigdata/pig/bin:/bigdata/hive/bin" >> ~/.bashrc

. ~/.bashrc


#
#FORMAT HADOOP NAMENODE
#
hdfs namenode -format

#
#start HDFS & YARN clusters
#
start-dfs.sh
start-yarn.sh

cd /bigdata

#
#INSTALL APACHE PIG
#
wget http://www-eu.apache.org/dist/pig/pig-0.16.0/pig-0.16.0.tar.gz
tar -zxvf pig-0.16.0.tar.gz
mv pig-0.16.0 pig

#
#INSTALL APACHE HIVE
#
wget http://www-us.apache.org/dist/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz
tar -zxvf apache-hive-2.1.1-bin.tar.gz
mv apache-hive-2.1.1-bin hive

#
#PATH ALREADY ADDED FOR PIG & HIVE
#
