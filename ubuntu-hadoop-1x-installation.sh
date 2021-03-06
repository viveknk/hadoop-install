
#Steps to install Hadoop 1.x
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

# if this link does not work, get the latest active mirror link from apache hadoop website
wget http://apache.mirrors.hoobly.com/hadoop/common/hadoop-1.2.1/hadoop-1.2.1-bin.tar.gz

tar -zxvf hadoop-1.2.1-bin.tar.gz
mv hadoop-1.2.1 hadoop

cd /bigdata/hadoop/conf
wget -O core-site.xml http://viveknk.com/hadoop/conf/core-site.txt
wget -O mapred-site.xml http://viveknk.com/hadoop/conf/mapred-site.txt
wget -O hdfs-site.xml http://viveknk.com/hadoop/conf/hdfs-site.txt

echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /data/hadoop/conf/hadoop-env.sh

hadoop namenode -format

#
#ADD HADOOP BIN DIR TO SYSTEM PATH
#
echo "export PATH=$PATH:/bigdata/hadoop/bin" >> ~/.bashrc
. ~/.bashrc

start-all.sh

#Now hadoop is ready to be started.


cd /bigdata

#INSTALL APACHE HIVE (later we will see how to setup hive metastore)
#
# if this link does not work, get the latest active mirror link from apache hive website
wget https://archive.apache.org/dist/hive/hive-0.13.1/apache-hive-0.13.1-bin.tar.gz
tar -zxvf apache-hive-0.13.1-bin.tar.gz 
mv apache-hive-0.13.1-bin hive

#INSTALL APACHE PIG
#
# if this link does not work, get the latest active mirror link from apache pig website
wget http://archive.apache.org/dist/pig/pig-0.12.1/pig-0.12.1.tar.gz
tar -zxvf pig-0.12.1.tar.gz 
mv pig-0.12.1 pig

sudo apt-get install apache2
sudo apt-get install mysql-server

#INSTALL APACHE SQOOP
#
# if this link does not work, get the latest active mirror link from apache sqoop website
wget http://mirror.tcpdiag.net/apache/sqoop/1.4.6/sqoop-1.4.6.bin__hadoop-1.0.0.tar.gz
tar -zxvf sqoop-1.4.6.bin__hadoop-1.0.0.tar.gz
mv sqoop-1.4.6.bin__hadoop-1.0.0 sqoop
cd sqoop/lib
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz
tar -zxvf mysql-connector-java-5.1.36.tar.gz
cp mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar .


#
#ADD PIG HIVE AND SQOOP BIN DIR TO SYSTEM PATH
#
echo "export PATH=$PATH:/bigdata/pig/bin:/bigdata/hive/bin:/bigdata/sqoop/bin" >> ~/.bashrc
. ~/.bashrc

