# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all

User.create(username: "AkramDriscoll", display_name: "Akram Driscoll", password: "test", password_confirm: "test")
User.create(username: "EliseCallahan", display_name: "Elise Callahan", password: "test", password_confirm: "test")
User.create(username: "HectorTravis", display_name: "Hector Travis", password: "test", password_confirm: "test")
User.create(username: "AmiCharlton", display_name: "Ami Charlton", password: "test", password_confirm: "test")
User.create(username: "EmaStout", display_name: "Ema Stout", password: "test", password_confirm: "test")
User.create(username: "IndianaZimmerman", display_name: "Indiana Zimmerman", password: "test", password_confirm: "test")
User.create(username: "LillyAnnOsborne", display_name: "Lilly-Ann Osborne", password: "test", password_confirm: "test")
User.create(username: "KajusSellers", display_name: "Kajus Sellers", password: "test", password_confirm: "test")
User.create(username: "MaisieFitzgerald", display_name: "Maisie Fitzgerald", password: "test", password_confirm: "test")
User.create(username: "MahekTyler", display_name: "Mahek Tyler", password: "test", password_confirm: "test")

Transfer.create(receiver: User.find_by(id: 2),sender: User.find_by(id: 1),amount: 10, note: "Lunch", status: "pending")
Transfer.create(receiver: User.find_by(id: 3),sender: User.find_by(id: 1),amount: 10, note: "Lunch", status: "completed")




