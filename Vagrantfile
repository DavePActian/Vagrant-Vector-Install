#-------------------------------------------------------------------------------

# Copyright 2015 Actian Corporation
 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
 
# http://www.apache.org/licenses/LICENSE-2.0
 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#-------------------------------------------------------------------------------

# Pre-requisites required before running this script:
#   1. Install Vagrant (Version 1.7.4 used constructing the above)
#   2. Install Oracle Virtual Box (5.0.4 or later) 
#   3. Enable hardware virtulaisation in the BIOS if it is disabled.

# This Vagrant script will perfom the following operations:
#   1. Create a Cento 6.7 Linux environment that is fully up to date.
#   2. Install, via Chef, Actian Vector previously downloaded.
#   3. Run the Actian DBT3 tests.

#-------------------------------------------------------------------------------

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "box-cutter/centos67"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Give the VM an appropriate name
    vb.name = "VectorEvaluationVM"
    # Customize the amount of memory on the VM 
    vb.memory = "4096"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    sed -i \'s/^SELINUX=.*$/SELINUX=disabled/\' /etc/selinux/config
    yum -y update
    # Required for DBT3 Scripts
    yum -y install git gcc time
    # Required for Vector
    yum -y install libaio
    # Required for Vector rpm 
    yum -y install libX11 libXext libXi libXrender libXtst alsa-lib
  SHELL

# Install Vector. Vector download must be in same location as this Vagrant file.

  config.vm.provision "chef_apply" do |chef|
    chef.recipe = File.read("./vector-installer.rb")
  end

# Set the Actian passwd

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    sudo su - -c 'echo -e "actian\nactian" | passwd actian > /tmp/passwd.log 2>&1'
  SHELL

# Always Start Vector. Doesn't matter if already started on initial install
#                      Required for restart.      

  config.vm.provision 'shell', run: 'always', privileged: true, inline: <<-SHELL
    sudo su - actian -c 'ingstart > /tmp/ingstart.log 2>&1; echo "Done"'
  SHELL

# Give actian sudo access with NOPASSWD

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    echo 'actian ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/actian
  SHELL

# Download and Run the DBT3 test suite 

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    cd /home/actian
    if [ ! -d VectorH-DBT3-Scripts ]; then
      su actian -c 'git clone -q https://github.com/ActianCorp/VectorH-DBT3-Scripts'
      su - actian -c 'cd VectorH-DBT3-Scripts;chmod 755 *.sh;./load-run-dbt3-benchmark.sh > /tmp/load-run-dbt3-benchmark.log 2>&1'
    fi
  SHELL

end

#-------------------------------------------------------------------------------
# End of Vagrant script
#-------------------------------------------------------------------------------
