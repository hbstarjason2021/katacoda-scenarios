1.Initializing Environment 
```bash
apt-get update && \
sudo apt-get install openjdk-11-jdk -y
```{{execute}}

```bash
JAVA_HOME=$(dirname $( readlink -f $(which java) ))
JAVA_HOME=$(realpath "$JAVA_HOME"/../)
export JAVA_HOME
```{{execute}}

2.Install Halyard
```bash
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh && \
 chmod +x ./InstallHalyard.sh && \
 useradd -m zhang && \
 bash InstallHalyard.sh --user zhang -y
```{{execute}}

```bash
hal -v    
hal version list
```{{execute}}

3.Install kubecolor
```bash
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_x86_64.tar.gz && \
tar zvxf kubecolor_0.0.20_Linux_x86_64.tar.gz && \
cp kubecolor /usr/local/bin/ && \
kubecolor version
```{{execute}}

`kubecolor get pod -A`{{execute}}

4.Install Minio

5.Deploy Spinnaker
