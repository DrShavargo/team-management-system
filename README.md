# Team Management System

[![Code Climate](https://codeclimate.com/github/DrShavargo/team-management-system.svg)](https://codeclimate.com/github/DrShavargo/team-management-system)
[![Security](https://hakiri.io/github/DrShavargo/team-management-system/master.svg)](https://hakiri.io/github/DrShavargo/team-management-system/master)

A system to oversee student teams, built on Rails, for a software design class.

#### Ruby Version
2.2.1

## System Depedencies

You will need the following installed:
* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [PostgreSQL](http://www.postgresql.org/)
* A Ruby version manager ([rvm](https://rvm.io/)/[rbenv](https://github.com/rbenv/rbenv))
* [Homebrew](http://brew.sh/), if developing on OSX

## Configuration

Depending on your system and setup, configuration of the above will vary. Ther are plenty of good tutorials online!

## Database Creating

To set up the pg database via console, login to postres, then run the following command
```console
create role tms with createdb login password 'password1';
```

## Installation

Clone the repository, then run:
```console
bundle install
```

Remove the template file ending from database.yml
```console
cp config/database.yml.tmpl config/database.yml
```
and modify the file to match your local pg database settings (should already match)

In console, setup the db and run the server:
```console
rake db:setup
rails s
```

If everything well went, you should be live!

## Authors

[Georges-Antoine Assi](https://github.com/DrShavargo)  
[Christopher Beauclair](https://github.com/Cbeaucl)

## License

Sprockets Rails is released under the [MIT License](MIT-LICENSE).
