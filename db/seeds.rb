# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create Companies first
company1 = Company.find_or_create_by!(name: "ABC Construction Ltd")
company2 = Company.find_or_create_by!(name: "XYZ Infrastructure")

# Create Users (you might need to adjust based on your authentication setup)
unless User.exists?(email: "admin@example.com")
  user1 = User.create!(
    email: "admin@example.com", 
    password: "password123",
    password_confirmation: "password123",
    role: "admin"
  )
else
  user1 = User.find_by(email: "admin@example.com")
  user1.update!(role: "admin")
end

unless User.exists?(email: "manager@example.com")
  user2 = User.create!(
    email: "manager@example.com", 
    password: "password123", 
    password_confirmation: "password123",
    role: "manager"
  )
else
  user2 = User.find_by(email: "manager@example.com")
  user2.update!(role: "manager")
end

# Create additional sample users with different roles
unless User.exists?(email: "owner@example.com")
  User.create!(
    email: "owner@example.com", 
    password: "password123",
    password_confirmation: "password123",
    role: "owner"
  )
end

unless User.exists?(email: "employee@example.com")
  User.create!(
    email: "employee@example.com", 
    password: "password123",
    password_confirmation: "password123",
    role: "employee"
  )
end

# Create Projects
project1 = Project.find_or_initialize_by(name: "Downtown Office Complex")
project1.update!(
  location: "Downtown",
  status: "Active",
  start_date: Date.today,
  end_date: Date.today + 90,
  customer_budget: 1000000,
  company: company1,
  user: user1
)

project2 = Project.find_or_initialize_by(name: "Residential Tower")
project2.update!(
  location: "Suburbs",
  status: "Active",
  start_date: Date.today,
  end_date: Date.today + 120,
  customer_budget: 2500000,
  company: company2,
  user: user2
)

# Create Team Heads first
team_head1 = TeamHead.find_or_create_by!(aadhaar_number: "123456789012") do |head|
  head.name = "John Smith"
  head.dob = Date.new(1985, 6, 15)
  head.age = 39
  head.gender = "Male"
  head.address = "123 Main Street, Downtown Area, City - 100001"
  head.contact_number = "9876543210"
end

team_head2 = TeamHead.find_or_create_by!(aadhaar_number: "123456789013") do |head|
  head.name = "Sarah Johnson"
  head.dob = Date.new(1988, 3, 22)
  head.age = 36
  head.gender = "Female"
  head.address = "456 Oak Avenue, Central District, City - 100002"
  head.contact_number = "9876543211"
end

team_head3 = TeamHead.find_or_create_by!(aadhaar_number: "123456789014") do |head|
  head.name = "Mike Wilson"
  head.dob = Date.new(1982, 11, 8)
  head.age = 42
  head.gender = "Male"
  head.address = "789 Pine Road, Suburban Area, City - 100003"
  head.contact_number = "9876543212"
end

team_head4 = TeamHead.find_or_create_by!(aadhaar_number: "123456789015") do |head|
  head.name = "Lisa Brown"
  head.dob = Date.new(1990, 9, 12)
  head.age = 34
  head.gender = "Female"
  head.address = "321 Elm Street, Residential Zone, City - 100004"
  head.contact_number = "9876543213"
end

# Create Teams with different nature_of_skill values
team1 = Team.find_or_create_by!(name: "Electrical Team") do |team|
  team.nature_of_skill = "electrical"
  team.team_head = team_head1
end

team2 = Team.find_or_create_by!(name: "Plumbing Team") do |team|
  team.nature_of_skill = "plumbing"
  team.team_head = team_head2
end

team3 = Team.find_or_create_by!(name: "Carpentry Team") do |team|
  team.nature_of_skill = "carpentry"
  team.team_head = team_head3
end

team4 = Team.find_or_create_by!(name: "Mason Team") do |team|
  team.nature_of_skill = "masonry"
  team.team_head = team_head4
end

team5 = Team.find_or_create_by!(name: "General Workers") do |team|
  team.nature_of_skill = "local_team"
  team.team_head = team_head1  # Can reuse team heads
end

# Create Head Workers (these workers don't have a head_worker)
head1 = Worker.find_or_create_by!(worker_id: "W1000") do |worker|
  worker.name = "John Smith"
  worker.contact = "9876543210"
  worker.project = project1
  worker.team = team1
  worker.nature_of_worker = :head
  worker.head_worker_id = nil
end

head2 = Worker.find_or_create_by!(worker_id: "W1001") do |worker|
  worker.name = "Sarah Johnson"
  worker.contact = "9876543211"
  worker.project = project1
  worker.team = team2
  worker.nature_of_worker = :head
  worker.head_worker_id = nil
end

head3 = Worker.find_or_create_by!(worker_id: "W1002") do |worker|
  worker.name = "Mike Wilson"
  worker.contact = "9876543212"
  worker.project = project2
  worker.team = team3
  worker.nature_of_worker = :head
  worker.head_worker_id = nil
end

head4 = Worker.find_or_create_by!(worker_id: "W1003") do |worker|
  worker.name = "Lisa Brown"
  worker.contact = "9876543213"
  worker.project = project2
  worker.team = team4
  worker.nature_of_worker = :head
  worker.head_worker_id = nil
end

# Create regular workers under heads
Worker.find_or_create_by!(worker_id: "W1004") do |worker|
  worker.name = "Robert Garcia"
  worker.contact = "9876543220"
  worker.project = project1
  worker.team = team1
  worker.head_worker = head1
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1005") do |worker|
  worker.name = "Emily Davis"
  worker.contact = "9876543221"
  worker.project = project1
  worker.team = team2
  worker.head_worker = head2
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1006") do |worker|
  worker.name = "David Martinez"
  worker.contact = "9876543222"
  worker.project = project2
  worker.team = team3
  worker.head_worker = head3
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1007") do |worker|
  worker.name = "Anna Rodriguez"
  worker.contact = "9876543223"
  worker.project = project2
  worker.team = team4
  worker.head_worker = head4
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1008") do |worker|
  worker.name = "Carlos Lopez"
  worker.contact = "9876543224"
  worker.project = project1
  worker.team = team5
  worker.head_worker = head1  # Can report to head1
  worker.nature_of_worker = :regular
end

# Create a few more subordinates
Worker.find_or_create_by!(worker_id: "W1009") do |worker|
  worker.name = "Maria Gonzalez"
  worker.contact = "9876543225"
  worker.project = project1
  worker.team = team1
  worker.head_worker = head1
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1010") do |worker|
  worker.name = "James Thompson"
  worker.contact = "9876543226"
  worker.project = project2
  worker.team = team3
  worker.head_worker = head3
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1011") do |worker|
  worker.name = "Jennifer Lee"
  worker.contact = "9876543227"
  worker.project = project2
  worker.team = team4
  worker.head_worker = head4
  worker.nature_of_worker = :regular
end

Worker.find_or_create_by!(worker_id: "W1012") do |worker|
  worker.name = "Michael Brown"
  worker.contact = "9876543228"
  worker.project = project1
  worker.team = team2
  worker.head_worker = head2
  worker.nature_of_worker = :regular
end

# Create Bank Details for some workers
puts "Creating bank details..."

# Bank details for head workers
BankDetail.find_or_create_by!(worker: head1) do |bank|
  bank.name_of_beneficiary = "John Smith"
  bank.account_number = "1234567890123456"
  bank.bank_name = "State Bank of India"
  bank.ifsc_code = "SBIN0001234"
  bank.branch_name = "Main Branch Downtown"
end

BankDetail.find_or_create_by!(worker: head2) do |bank|
  bank.name_of_beneficiary = "Sarah Johnson"
  bank.account_number = "9876543210987654"
  bank.bank_name = "HDFC Bank"
  bank.ifsc_code = "HDFC0002345"
  bank.branch_name = "Commercial Street Branch"
end

BankDetail.find_or_create_by!(worker: head3) do |bank|
  bank.name_of_beneficiary = "Mike Wilson"
  bank.account_number = "5678901234567890"
  bank.bank_name = "ICICI Bank"
  bank.ifsc_code = "ICIC0003456"
  bank.branch_name = "Industrial Area Branch"
end

# Bank details for some regular workers
robert = Worker.find_by(worker_id: "W1004")
if robert
  BankDetail.find_or_create_by!(worker: robert) do |bank|
    bank.name_of_beneficiary = "Robert Garcia"
    bank.account_number = "1122334455667788"
    bank.bank_name = "Punjab National Bank"
    bank.ifsc_code = "PUNB0004567"
    bank.branch_name = "City Center Branch"
  end
end

emily = Worker.find_by(worker_id: "W1005")
if emily
  BankDetail.find_or_create_by!(worker: emily) do |bank|
    bank.name_of_beneficiary = "Emily Davis"
    bank.account_number = "9988776655443322"
    bank.bank_name = "Axis Bank"
    bank.ifsc_code = "UTIB0005678"
    bank.branch_name = "Suburban Branch"
  end
end

puts "✅ Seed data created successfully!"
puts "📊 Created:"
puts "  - #{Company.count} companies"
puts "  - #{User.count} users" 
puts "  - #{Project.count} projects"
puts "  - #{TeamHead.count} team heads"
puts "  - #{Team.count} teams"
puts "  - #{Worker.count} workers"
puts "  - #{BankDetail.count} bank details"
puts ""
puts "🔧 Teams available for selection:"
Team.all.each do |team|
  puts "  - #{team.name} (#{team.nature_of_skill})"
end
puts ""
puts "👥 Worker Hierarchy:"
Worker.heads.each do |head|
  puts "📊 HEAD: #{head.name} (#{head.worker_id}) - Team: #{head.team&.name}"
  head.subordinates.each do |subordinate|
    puts "  ├─ #{subordinate.name} (#{subordinate.worker_id}) - Team: #{subordinate.team&.name}"
  end
  puts ""
end

puts ""
puts "=" * 60
puts "🔑 CREATING SUPER ADMIN USER: NARENTHAR"
puts "=" * 60

# Create super admin user: narenthar
unless User.exists?(email: "narentharbluvent@gmail.com")
  narenthar = User.create!(
    email: "narentharbluvent@gmail.com", 
    password: "Login@bv2025",
    password_confirmation: "Login@bv2025",
    role: "owner"
  )
  puts "✅ Created super admin user: narentharbluvent@gmail.com (Owner + Super Admin)"
else
  narenthar = User.find_by(email: "narentharbluvent@gmail.com")
  narenthar.update!(
    password: "Login@bv2025",
    password_confirmation: "Login@bv2025",
    role: "owner"
  )
  puts "✅ Updated super admin user: narentharbluvent@gmail.com"
end

puts ""
puts "🔐 UPDATING ALL USER PASSWORDS TO: Login@bv2025"
puts "-" * 60

# Update all users' passwords to Login@bv2025
User.all.each do |user|
  user.update!(
    password: "Login@bv2025",
    password_confirmation: "Login@bv2025"
  )
  puts "✅ Updated password for: #{user.email} (#{user.role_display})"
end

puts ""
puts "=" * 60
puts "📊 FINAL USER SUMMARY"
puts "=" * 60
puts "Total users: #{User.count}"
puts "Super admins (with bluvent@gmail.com): #{User.all.select(&:super_admin?).count}"
puts "Owners: #{User.where(role: 'owner').count}"
puts "Admins: #{User.where(role: 'admin').count}"
puts "Managers: #{User.where(role: 'manager').count}"
puts "Employees: #{User.where(role: 'employee').count}"

puts ""
puts "👑 NARENTHAR USER CAPABILITIES"
puts "-" * 60
narenthar = User.find_by(email: "narentharbluvent@gmail.com")
if narenthar
  puts "📧 Email: #{narenthar.email}"
  puts "👤 Role: #{narenthar.role_display}"
  puts "⭐ Super Admin: #{narenthar.super_admin? ? 'YES (can create admins)' : 'NO'}"
  puts "👥 Can Create Users: #{narenthar.can_create_users? ? 'YES' : 'NO'}"
  puts "✏️  Can Edit All Users: #{narenthar.owner? ? 'YES' : 'NO'}"
  puts "🔓 Complete System Access: YES"
  puts "🔑 Login Password: Login@bv2025"
end

puts ""
puts "🎉 ALL OPERATIONS COMPLETED SUCCESSFULLY!"
puts "🔐 All user passwords have been set to: Login@bv2025"
puts "=" * 60