# Create Super Admin User Script
# Run this in Rails console: rails console
# Then paste this code:

puts "=== Creating Super Admin User ==="

# Super Admin user details
super_admin_email = "superadminbluvent@gmail.com"  # Must contain 'bluvent@gmail.com' for super_admin? to work
super_admin_password = "SuperAdmin@2025"

# Check if user already exists
existing_user = User.find_by(email: super_admin_email)

if existing_user
  puts "❌ User with email '#{super_admin_email}' already exists!"
  puts "Current role: #{existing_user.role_display}"
  puts "Super Admin?: #{existing_user.super_admin?}"
else
  # Create new super admin user
  super_admin = User.new(
    email: super_admin_email,
    password: super_admin_password,
    password_confirmation: super_admin_password,
    role: 'owner'  # Highest role level
  )
  
  if super_admin.save
    puts "✅ Super Admin user created successfully!"
    puts "📧 Email: #{super_admin.email}"
    puts "🔑 Password: #{super_admin_password}"
    puts "👑 Role: #{super_admin.role_display}"
    puts "🔥 Super Admin?: #{super_admin.super_admin?}"
    puts "🛡️  Can create users?: #{super_admin.can_create_users?}"
    puts "🎯 Can create admins?: #{super_admin.can_create_admin?}"
  else
    puts "❌ Failed to create super admin user:"
    super_admin.errors.full_messages.each do |error|
      puts "  - #{error}"
    end
  end
end

puts "=== Super Admin Creation Complete ==="
