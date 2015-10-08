This Vagrant 'package' will configure a Centos 6.7 Linux box with an evaluation edition of Vector installed and running. Additionally, the Actian DBT3 benchmark data will be installed and run.

The essential files are:

1. Vagrantfile
2. vector-install.rb (Chef ruby script)

This package was tested using Vagrant 1.7.4, CentOS 6.7 and Oracle Virtual Box 5.0.4.

To achieve this there are certain mandatory pre-requisites that must be fullfiled:

1. Install Vagrant (Version 1.7.4 used constructing the above)
2. Install Oracle Virtual Box (5.0.4 or later) 
3. Enable hardware virtulaisation in the BIOS if it is disabled.

To get your Vector installation up and running:

1. Download the Actian Vector Evaluation installation package from here : http://bigdata.actian.com/Vector
   This can either be the native package manager independent download.
       e.g. actian-vector-4.2.1-190-eval-linux-ingbuild-x86_64.tgz
   OR the RPM format binaries.
       e.g. actian-vector-4.2.1-190-eval-linux-rpm-x86_64.tgz
2. You will receive an authorisation string. Copy this string to a file called "authstring" (No file type suffix). This is regardless of the type of Vector installation package download.
3. If you chose the RPM binaries package also download the associated Public Key file.
       e.g. actian-vector-4.2.1-190-eval-linux-rpm-x86_64-key.asc
4. Create a directory e.g. "c:\VectorEval"
5. Into this directory copy the files in this package, the Vector Evaluation installation package e.g. actian-vector-4.2.1-190-eval-linux-ingbuild-x86_64.tgz and the "authstring" file you created.
6. If you chose the RPM binaries package also copy the Public key file to the directory.
7. From a command prompt at the directory you created run "vagrant up"

A terminal screen will be displayed for the VM created.
The complete configuration can take up to 10 minutes dependent on the speed of your network.

When complete logon as User: actian, Password : actian

At this point the Vector environment is fully configured for you to use. 

The DBT3 test scripts have been run. The following output fils are applicable:

1. Run log - /tmp/load-run-dbt3-benchmark.log
2. Run results - /actian/home/VectorH-DBT3-Scripts/run_performance.out

