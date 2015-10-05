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

# This chef script will install a previously downloaded evaluation edition of 
# Actain Vector as installation VE in /opt/Actian/Vector.

#-------------------------------------------------------------------------------


# Setup the required user and user structure                   

user "actian" do
  uid "400"
  home "/home/actian"
  manage_home true
  shell "/bin/bash"
end

directory "/home/actian/installer" do
  owner "actian"
  mode 00700
  recursive true
end

directory "/home/actian/.ssh" do
  owner "actian"
  mode 00700
  recursive true
end

file "/home/actian/.bashrc" do
  content <<-EOH
[ -f ~/.ingVEsh ] && source ~/.ingVEsh
EOH
  owner "actian"
  mode 00700
end

# Variables for files and locations used

vector_package = `ls -t /vagrant/actian-vector*tgz | head -1`

vector_install_loc = "/home/actian/installer/"
vector_installation = `ls -t /vagrant/actian-vector*tgz | head -1 | tr -d "\n" | sed "s/vagrant//" | sed "s/.tgz//"`

installer = ::File.join( vector_install_loc, vector_installation, "/express_install.sh" )
authstring = ::File.join( vector_install_loc, vector_installation, "/authstring" )

# Untar the Vector installation package

execute "tar -xzf #{vector_package}" do
  cwd "#{vector_install_loc}"
  not_if { File.exist?("#{installer}") }
end

# Copy over the authstring

file "#{authstring}" do
  mode 0755
  content ::File.open("/vagrant/authstring").read
  action :create
  not_if { File.exist?("#{authstring}") }
end

# Install Vector

bash 'run installer' do  
  code <<-EOH
    #{installer} -acceptlicense /opt/Actian/Vector VE > /tmp/vhinst.log 2>&1
  EOH
  not_if { File.exist?("/opt/Actian/Vector/ingres/files/errlog.log") }
end

#-------------------------------------------------------------------------------
# End of Chef ruby script
#-------------------------------------------------------------------------------
