require 'faker'
require 'net/http'

puts "Destroying rows"


roles = ['staff', 'artist', 'security']
puts "Creating organizers..."

User.create!(email: 'soufiane@iivent.com', password: 'password', first_name: 'Soufiane', last_name: 'Ezzine', nickname: 'Kryp', phone_number: '08043565676', line_id: 'kryp01', location: 'Tokyo, Japan', role: 'organizer', avatar_url: 'https://avatars.githubusercontent.com/u/59670612?v=4')
User.create!(email: 'mounir@iivent.com', password: 'password', first_name: 'Mounir', last_name: 'Jamghili', nickname: 'MounB', phone_number: '08023454543', line_id: 'mounb', location: 'Tokyo, Japan', role: 'organizer', avatar_url: 'https://avatars.githubusercontent.com/u/107523103?v=4')
User.create!(email: 'kyle@iivent.com', password: 'password', first_name: 'Kyle', last_name: 'Jeffrey', nickname: 'kylejeffrey', phone_number: '08123456754', line_id: 'kyleJ', location: 'Osaka, Japan', role: 'organizer', avatar_url: 'https://avatars.githubusercontent.com/u/76161172?v=4')
User.create!(email: 'Mark@iivent.com', password: 'password', first_name: 'Mark', last_name: 'Rawlins', nickname: '5F8575tree', phone_number: '08009984348', line_id: '5F8575tree', location: 'Osaka, Japan', role: 'organizer', avatar_url: 'https://avatars.githubusercontent.com/u/96557207?v=4')

puts "Seeding Members"

uri = URI('https://randomuser.me/api/?results=30')
response = JSON.parse(Net::HTTP.get(uri))["results"]

response.each do |user|

  User.create!(
    email: user["email"],
    password: 'password',
    first_name: user["name"]["first"],
    last_name: user["name"]["last"],
    nickname: user["login"]["username"],
    phone_number: user["phone"],
    line_id: user["login"]["salt"],
    location: "#{user['location']['city']}, #{user['location']['country']}",
    role: roles.sample)
end

puts "Creating events"

Event.create!(location: 'Tokyo', start_date: Date.today + 1.month, end_date: Date.today + 2.month, name: 'Power Base', poster_url: '')
Event.create!(location: 'Osaka', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Tomorrowland')
Event.create!(location: 'Kyoto', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Mario & Luigi')
Event.create!(location: 'Nagoya', start_date: Date.today + rand(1..2).month, end_date: Date.today + rand(3..4).month, name: 'Lafouine feat Booba le Petit Ourson')

puts "Creating Tasks"
task = ['music', 'security', 'promotion', 'catering', 'org']

event_one = Event.all.first
event_two = Event.find(2)

Task.create!(name: 'Sound check', description: 'Set times for artist soundchecks before showtime', category: 'music', event: event_one, start: Date.today + 1.month + 1.day, end: Date.today + 1.month + 3.day)
Task.create!(name: 'Contact food trucks', description: 'Securing offers for food Trucks around the venue', category: 'catering', status:'archived', event: event_one)
Task.create!(name: 'Social Media Setup', description: 'Setup event pages on different social medias', category: 'promotion', event: event_one)
Task.create!(name: 'Securing secutiry contract', description: 'Find a security company to assure secutiry during the event', category: 'security', event: event_one)
Task.create!(name: 'Book Headliner', description: 'Secure headlining artist for the event', category: 'org', event: event_one)
Task.create!(name: 'Book Venue', description: 'Find and secure a venue for event - 150-500 capacity', category: 'org', event: event_one)
Task.create!(name: 'Schedule staff', description: 'Bar staff, front-of-house (sound), lighting/visuals', category: 'org', event: event_one)
Task.create!(name: 'Rent Gear', description: 'Rent 4x CDJ-2000 NX2’s + DJM900NX2 Mixer', category: 'music', event: event_one)
Task.create!(name: 'Book local DJ\'s & MC\'s', description: 'Find 3-4 local artists to open the show and close it', category: 'music', event: event_one)
Task.create!(name: 'Determine Timetable', description: 'Set timetable/order of performers', category: 'org', event: event_one)
Task.create!(name: 'Have promotional materials made', description: 'Have event poster(physical & digital versions) made', category: 'promotion', event: event_one)
Task.create!(name: 'Distribute Promo Materials', description: 'Distribute physical flyers/posters around town and give digital materials to all those affiliated with the event to post on social media', category: 'promotion', event: event_one)
Task.create!(name: 'Set Reminders for Social Media Promotion', description: 'Artists and staff should post about the event on social media at set intervals in lead up to the event', category: 'org', event: event_one)
Task.create!(name: 'Restock Bar', description: 'Make sure bar(s) are fully stocked the day of the event', category: 'catering', event: event_one)
Task.create!(name: 'Book Headliner\'s Hotel Accomodations', description: 'Find hotel accomodations for headlining artist - per their specifications', category: 'music', event: event_one)
Task.create!(name: 'Book Catering', description: 'Secure a local caterer for food in rest area of event', category: 'catering', event: event_one)
Task.create!(name: 'Organize Headliner transportation', description: 'Reserve a car to transport headliner to / from the event', category: 'org', event: event_one)
Task.create!(name: 'Wristbands', description: 'Make sure we have enough wristbands for both artists / vip / general attendees', category: 'security', event: event_one)
Task.create!(name: 'Lighting/Visuals', description: 'Provide space and access to connections for lights/smoke/visuals', category: 'org', event: event_one)

Task.all.each do |task|
  rand(3..7).times do
    Task.create!(name: 'Subtask...', event: Event.all.first, category: task.category, task: task)
  end
end

# puts "creating Event memeber"
# puts "organizers"
# User.all.first(4).each do |member|
#   EventMember.create!(user: member, event: Event.first, permission: 'organizer')
# end

# puts "creqting event members"

# EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
# EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
# EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")
# EventMember.create!(user: (User.all - User.all.first(4)).sample, event: Event.first, permission: "member")


# puts "Creating task memebr"

# TaskMember.create!(task: Task.all.first, event_member: EventMember.all.last)
# TaskMember.create!(task: Task.all.first, event_member: EventMember.all[-2])

puts "finished"
