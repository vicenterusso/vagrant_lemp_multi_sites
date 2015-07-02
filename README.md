# A LEMP vagrant machine

## Introduction

This project automates the setup of a LEMP multi-site development environment. Based on [Veselin Vasilev](https://github.com/vesselinv/vagrant-lemp) project, it uses simple folder structure and a template file to setup multiple vhosts on Nginx.

## Requirements

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)
* [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) for auto dumping databases when Halt
* [Cygwin](https://www.cygwin.com/) or any other ssh-capable terminal shell for the `vagrant ssh` command

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/vicenterusso/vagrant_lemp_multi_sites.git
    host $ cd vagrant_lemp_multi_sites
    host $ vagrant up --provision

If the base box is not present that command fetches it first.

    host $ vagrant ssh
    Welcome to Ubuntu 14.04 LTS ...
    ...
    vagrant@vagrant:~$

Ports 80 and 3306 on guest and forwarded to 8080 and 33306 respectively.

## What's In The Box

* Ubuntu 14.04 x64
* MySQL
* Nginx
* php5-fpm

## Recommended Workflow

The recommended workflow is

* edit files in the host computer

* run within the virtual machine

Your home folder is synced to `/vagrant` on the guest.

## Database
* For mysql the default user is root with blank password: `mysql -u root`

## Tutorial

This is the folder structure that you will need to follow: 

```
+-- db
|   +-- dbname1
|       -- dump.sql [optional]
|       -- created [auto created]
|   +-- dbname2
|       -- dump.sql [optional]
+-- nginx_template
|   +-- mysite1.com
|       -- created [auto created]
|   +-- mysite2.com
|       -- created [auto created]
|   +-- nginx-vhost-template.conf
+-- sites
|   +-- mysite1.com [project files (www)]
|   +-- mysite2.com [project files (www)]
```

In this example, Vagrant will create 2 databases named `dbname1` and `dbname2`. A file named `created` will be created inside each database folder. This is just a flag, that means your next `vagrant provision` won't try to create your database again. the `dump.sql` will be executed when creating if exists. If you want to dump another set and recreate the database, just delete the `created` file. Dump files must have `use` statement for each database.

Inside `nginx_template` you will find the the `nginx-vhost-template.conf` that will be created and the domain used will be replaced by the folder name. So, in that case, `local.mysite1.com` and `local.mysite2.com` are valid projects.

## Virtual Machine Management

When done just log out with and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.
