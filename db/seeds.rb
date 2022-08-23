require 'faker'

puts "Destroying rows"
# User.destroy_all

roles = ['staff', 'artist', 'security']
puts "Creating organizers..."

User.create!(email: 'soufiane@iivent.com', password: 'password', first_name: 'Soufiane', last_name: 'Ezzine', nickname: 'Kryp', phone_number: '08043565676', line_id: 'kryp01', location: 'Tokyo, Japan', role: 'organizer')
User.create!(email: 'mounir@iivent.com', password: 'password', first_name: 'Mounir', last_name: 'Jamghili', nickname: 'MounB', phone_number: '08023454543', line_id: 'mounb', location: 'Tokyo, Japan', role: 'organizer')
User.create!(email: 'kyle@iivent.com', password: 'password', first_name: 'Kyle', last_name: 'Jeffrey', nickname: 'kylejeffrey', phone_number: '08123456754', line_id: 'kyleJ', location: 'Osaka, Japan', role: 'organizer')
User.create!(email: 'Mark@iivent.com', password: 'password', first_name: 'Mark', last_name: 'Rawlins', nickname: '5F8575tree', phone_number: '08009984348', line_id: '5F8575tree', location: 'Osaka, Japan', role: 'organizer')

puts "Seeding Members"

20.times do
  User.create!(email: Faker::Internet.unique.email, password: 'password', first_name: Faker::JapaneseMedia::DragonBall.character, last_name: Faker::Games::Dota.player, nickname: Faker::Games::Dota.unique.hero, phone_number: Faker::PhoneNumber.cell_phone, line_id: Faker::Movies::LordOfTheRings.unique.character, location: Faker::Address.full_address, role: roles.sample)
end
