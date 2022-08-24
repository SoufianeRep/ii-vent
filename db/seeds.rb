require 'faker'
require 'net/http'

puts "Destroying subtasks"
puts "Destroying events"
Event.destroy_all
puts "Destroying main tasks"
Task.destroy_all
puts "Destroying users"
User.destroy_all
puts "Destroying task members"
TaskMember.destroy_all
puts "Destroying event members"
EventMember.destroy_all

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
    avatar_url: user["picture"]["large"],
    role: roles.sample
  )
end

puts "Creating events"

Event.create!(location: 'Tokyo', start_date: DateTime.now + 1.month, end_date: DateTime.now + 2.month, name: 'Power Base', poster_url: 'https://www.6amgroup.com/wp-content/uploads/2016/12/The-right-DJ-can-improve-an-event.jpg')
Event.create!(location: 'Osaka', start_date: DateTime.now + rand(1..2).month, end_date: DateTime.now + rand(3..4).month, name: 'Tomorrowland', poster_url: 'https://img.freepik.com/free-vector/music-event-poster-template-with-abstract-shapes_1361-1316.jpg?w=2000&t=st=1661319012~exp=1661319612~hmac=6fe528e19dbfdb3bb1e1ff9dc23e6eb06fdcbb003cd436174c8084346804be97')
Event.create!(location: 'Kyoto', start_date: DateTime.now + rand(1..2).month, end_date: DateTime.now + rand(3..4).month, name: 'Mario & Luigi', poster_url: 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/12b6cf90105865.5e0df9f1b7f73.png')
Event.create!(location: 'Nagoya', start_date: DateTime.now + rand(1..2).month, end_date: DateTime.now + rand(3..4).month, name: 'Lafouine feat Booba le Petit Ourson', poster_url: 'https://scontent-nrt1-1.xx.fbcdn.net/v/t39.30808-6/218290032_1217610138651984_3186298974796388059_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=69bkw4gJDSsAX84IIfs&_nc_ht=scontent-nrt1-1.xx&oh=00_AT_q9koQafbBRCuJ9w0BiKAesNZsy3CDNcGZ0jLUcSMe2Q&oe=630A05C8')

puts "Creating Tasks"
task = ['music', 'security', 'promotion', 'catering', 'org']

event_one = Event.all.first
event_two = Event.all.first(2)[1]

Task.create!(name: 'Sound check', description: 'Set times for artist soundchecks before showtime', category: 'music', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Contact food trucks', description: 'Securing offers for food Trucks around the venue', category: 'catering', status:'archived', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Social Media Setup', description: 'Setup event pages on different social medias', category: 'promotion', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Securing secutiry contract', description: 'Find a security company to assure secutiry during the event', category: 'security', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Book Headliner', description: 'Secure headlining artist for the event', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Book Venue', description: 'Find and secure a venue for event - 150-500 capacity', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Schedule staff', description: 'Bar staff, front-of-house (sound), lighting/visuals', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Rent Gear', description: 'Rent 4x CDJ-2000 NX2’s + DJM900NX2 Mixer', category: 'music', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Book local DJ\'s & MC\'s', description: 'Find 3-4 local artists to open the show and close it', category: 'music', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Determine Timetable', description: 'Set timetable/order of performers', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Have promotional materials made', description: 'Have event poster(physical & digital versions) made', category: 'promotion', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Distribute Promo Materials', description: 'Distribute physical flyers/posters around town and give digital materials to all those affiliated with the event to post on social media', category: 'promotion', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Set Reminders for Social Media Promotion', description: 'Artists and staff should post about the event on social media at set intervals in lead up to the event', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Restock Bar', description: 'Make sure bar(s) are fully stocked the day of the event', category: 'catering', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Book Headliner\'s Hotel Accomodations', description: 'Find hotel accomodations for headlining artist - per their specifications', category: 'music', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Book Catering', description: 'Secure a local caterer for food in rest area of event', category: 'catering', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Organize Headliner transportation', description: 'Reserve a car to transport headliner to / from the event', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Wristbands', description: 'Make sure we have enough wristbands for both artists / vip / general attendees', category: 'security', event: event_one, start: DateTime.now, end: event_one.end_date)
Task.create!(name: 'Lighting/Visuals', description: 'Provide space and access to connections for lights/smoke/visuals', category: 'org', event: event_one, start: DateTime.now, end: event_one.end_date)

Task.all.each do |task|
  rand(3..7).times do
    Task.create!(name: 'Subtask...', event: Event.all.first, category: task.category, task: task)
  end
end

puts "creating Event memeber"
puts "organizers"
User.all.first(4).each do |member|
  EventMember.create!(user: member, event: event_one, permission: 'organizer')
  EventMember.create!(user: member, event: event_two, permission: 'organizer')
end

puts "creating event members"

users.first(15).each do |user|
  event_member = EventMember.create!(user: user, event: Event.all.first(2)[1], permission: "member")
  TaskMember.create!(task: Task.all.sample, event_member: event_member)
end

users.last(11).each do |user|
  event_member = EventMember.create!(user: user, event: Event.all.first(2)[1], permission: "member")
  TaskMember.create!(task: Task.all.sample, event_member: event_member)
end

puts "Creating task memebr"


puts "finished"
