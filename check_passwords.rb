# Password Checking Script for Rails Console
# Run in Rails console: rails console
# Then paste this code:

puts "=" * 60
puts "🔐 PASSWORD CHECKING DEMONSTRATION"
puts "=" * 60

# Common password from your system
test_password = "Login@bv2025"

puts "\n1️⃣ WHAT YOU CAN'T SEE (Security):"
puts "-" * 40

user = User.first
puts "user.password              → #{user.password.inspect}"
puts "user.password_digest       → N/A (this isn't used in Devise)"

puts "\n2️⃣ WHAT YOU CAN SEE:"  
puts "-" * 40
puts "user.email                 → #{user.email}"
puts "user.encrypted_password    → #{user.encrypted_password[0..20]}... (truncated)"
puts "user.role                  → #{user.role}"
puts "user.created_at            → #{user.created_at}"

puts "\n3️⃣ HOW TO CHECK PASSWORDS:"
puts "-" * 40

# Method 1: Check specific user's password
puts "\n🔍 Method 1: valid_password?(password)"
result = user.valid_password?(test_password)
puts "user.valid_password?(\"#{test_password}\") → #{result}"

puts "\n🔍 Method 2: Check all users"
User.limit(5).each do |u|
  status = u.valid_password?(test_password) ? "✅ CORRECT" : "❌ WRONG"
  puts "#{u.email.ljust(30)} → #{status}"
end

puts "\n4️⃣ FIND USER WITH CORRECT PASSWORD:"
puts "-" * 40

# Find users who have this password
matching_users = User.select { |u| u.valid_password?(test_password) }
puts "Users with password '#{test_password}':"
matching_users.each do |u|
  puts "  ✅ #{u.email} (#{u.role_display})"
end

puts "\n5️⃣ LOGIN SIMULATION:"
puts "-" * 40

# Simulate login process
email = "narentharbluvent@gmail.com"
password = "Login@bv2025"

user = User.find_by(email: email)
if user && user.valid_password?(password)
  puts "✅ LOGIN SUCCESS!"
  puts "   Email: #{user.email}"
  puts "   Role: #{user.role_display}"
  puts "   Super Admin: #{user.super_admin?}"
  puts "   Can create users: #{user.can_create_users?}"
else
  puts "❌ LOGIN FAILED!"
end

puts "\n6️⃣ PASSWORD CHANGE DEMONSTRATION:"
puts "-" * 40

# Show how to change password (don't actually do it)
puts "To change password:"
puts "user.password = 'new_password'"
puts "user.password_confirmation = 'new_password'" 
puts "user.save!"

puts "\n" + "=" * 60
puts "✨ Password checking complete!"
puts "Remember: Passwords are NEVER stored in plain text!"
puts "=" * 60








