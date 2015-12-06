# Team Management System

[![Code Climate](https://codeclimate.com/github/DrShavargo/team-management-system.svg)](https://codeclimate.com/github/DrShavargo/team-management-system)
[![Security](https://hakiri.io/github/DrShavargo/team-management-system/master.svg)](https://hakiri.io/github/DrShavargo/team-management-system/master)

A system to oversee student teams, built on Rails, for a software design class.


## Installation

1. Clone the repository, then run:
```console
bundle install
rake db:migrate
```

Remove the template file ending from database.yml
```console
cp config/database.yml.tmpl config/database.yml
```
and modify the file to match your local pg database settings


## Authors

[Georges-Antoine Assi](https://github.com/DrShavargo)  
[Christopher Beauclair](https://github.com/Cbeaucl)

## License

Sprockets Rails is released under the [MIT License](MIT-LICENSE).
