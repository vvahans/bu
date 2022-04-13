# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

certifiers = Certifier.create([
                                { name: 'London School of Cycling', email: 'lsc@bikes-unlimited.co.uk', locale: 'en'},
                                { name: 'Copenhagen School of Cycling', email: 'csc@bikes-unlimited.dk', locale: 'da'}])

admins = Admin.create([
                       {
                         first_name: 'John',
                         last_name: 'Smith',
                         email: 'john-smith@bikes-united.co.uk',
                         password: 'Password1!',
                         certifier: certifiers.first
                       },
                       {
                         first_name: 'Karla',
                         last_name: 'Jorgensen',
                         email: 'karla-jorgensen@bikes-united.dk',
                         password: 'Password2!',
                         certifier: certifiers.last
                       }
                     ])
