require 'faker'

puts "Destroying rows"


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

puts "Creating events"

Event.create!(location: 'Tokyo', start_date: Date.today + 1.month, end_date: Date.today + 2.month, name: 'Power Base')
Event.create!(location: 'Osaka', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Tomorrowland')
Event.create!(location: 'Kyoto', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Mario & Luigi')
Event.create!(location: 'Nagoya', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Lafouine feat Booba le Petit Ourson')

puts "Creating Tasks"
task = ['music', 'security', 'promotion', 'catering']

Task.create!(name: 'Sound check', category: 'music', event: Event.first, start: Date.today + 1.month + 1.day, end: Date.today + 1.month + 3.day)
Task.create!(name: 'Buying beverages', category: 'catering', status: 'done', event: Event.all.first)
Task.create!(name: 'Contact food trucks', category: 'catering', status:'archived', event: Event.all.first)
Task.create!(name: 'Social Media', category: 'promotion', event: Event.all.first)
Task.create!(name: 'Securing secutiry contract', category: 'security', event: Event.all.first)
Task.create!(name: 'Recruiting DJs', category: 'music', event: Event.all.first)



Task.all.each do |task|
  3.times do
    Task.create!(name: 'Subtask...', event: Event.all.first, category: task.category, task: task)
  end
end

puts "creating Event memeber"
puts "organizers"
User.all.first(4).each do |member|
  EventMember.create!(user: member, event: Event.first, permission: 'organizer')
end

puts "creqting event members"

EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")


puts "Creating task memebr"

TaskMember.create!(task: Task.all.first, event_member: EventMember.all.last)
TaskMember.create!(task: Task.all.first, event_member: EventMember.all[-2])

puts "finished"
