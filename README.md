# A LEMP vagrant machine

## Introduction

This project automates the setup of a LEMP development environment.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Cygwin](https://www.cygwin.com/) or any other ssh-capable terminal shell for the `vagrant ssh` command

## How To Build The Virtual Machine

Building the virtual machine is this easy:

  host $ git clone https://github.com/halyc0n/vagrant-lemp.git
  host $ cd vagrant-lemp
  host $ vagrant up --provision

If the base box is not present that command fetches it first.

  host $ vagrant ssh
  Welcome to Ubuntu 16.04 LTS ...
  ...
  ubuntu@ubuntu-xenial:~$

Port 80 on guest forwarded to 8080.

## What's In The Box

* Ubuntu 16.04 x64
* MySQL
* Nginx
* php7.0-fpm

## Recommended Workflow

The recommended workflow is

* edit files in the host computer

* run within the virtual machine

Your home folder is synced to `/home/ubuntu/project` on the guest.

## Database
* For mysql the default user is root with password 'pass': `mysql -u root -ppass`
* Also created database and user webapp with password 'password'

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
