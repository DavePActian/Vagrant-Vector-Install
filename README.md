This Vagrant 'package' will configure a Centos 6.7 Linux box with an evaluation edition of Vector installed and running. Additionally, the Actian DBT3 benchmark data will be installed and run.

The essential files are:

1. Vagrantfile
2. vector-install.rb (Chef ruby script)

This package was tested using Vagrant 1.7.4, CentOS 6.7 and Oracle Virtual Box 5.0.4.

To achieve this there are certain mandatory pre-requisites that must be fullfiled:

1. Install Vagrant (Version 1.7.4 used constructing the above)
2. Install Oracle Virtual Box (5.0.4 or later) 
3. Enable hardware virtulaisation in the BIOS if it is disabled.

To get your vector installation up and running:

1. Download the Actian Vector Evaluation from here : http://bigdata.actian.com/Vector
2. You will receive an authorisation string. Copy this string to a file called "authstring" (No file type suffix)
3. Create a directory e.g. "c:\VectorEval"
4. Into this directory copy the files in this package, the vector evaluation download file e.g. actian-vector-4.2.1-190-eval-linux-ingbuild-x86_64.tgz and the "authstring" file you created.
5. From a command prompt at the directory you created run "vagrant up"

A terminal screen will be displayed for the VM created.

Logon as User: actian, Password : actian

At this point the Vector environment is fully configured for you to use. 

The DBT3 test scripts have been run. The following output fils are applicable:

1. Run log - /tmp/load-run-dbt3-benchmark.log
2. Run results - /actian/home/VectorH-DBT3-Scripts/run_performance.out

