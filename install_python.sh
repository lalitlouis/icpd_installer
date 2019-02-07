# installing python 2.7.3
mkdir -p ~/local
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
tar xvzf Python-2.7.3.tgz
cd Python-2.7.3
./configure
make
make altinstall prefix=~/local  # specify local installation directory
ln -s ~/local/bin/python2.7 ~/local/bin/python
cd ..

# install setuptools and pip for package management
wget https://pypi.python.org/packages/source/s/setuptools/setuptools-7.0.tar.gz --no-check-certificate
tar xzf setuptools-7.0.tar.gz
cd setuptools-7.0
python setup.py install  # specify the path to the python you installed above
cd ..
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

rm -rf setuptools-7.0.tar.gz Python-2.7.3.tgz get-pip.py

