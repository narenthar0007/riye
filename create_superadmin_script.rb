#!/usr/bin/env ruby
# Super Admin Creation Script for Riye Construction Management
# Run this with: rails runner create_superadmin_script.rb

puts "\n" + "="*50
puts "🔥 SUPER ADMIN CREATION SCRIPT"
puts "="*50

# Super Admin Configuration
SUPER_ADMIN_EMAIL = "superadminbluvent@gmail.com"
SUPER_ADMIN_PASSWORD = "SuperAdmin@2025"

begin
  # Check if super admin already exists
  existing_user = User.find_by(email: SUPER_ADMIN_EMAIL)
  
  if existing_user
    puts "⚠️  User already exists!"
    puts "📧 Email: #{existing_user.email}"
    puts "👑 Role: #{existing_user.role_display}" 
    puts "🔥 Super Admin?: #{existing_user.super_admin?}"
    
    # Update to owner role if not already
    if existing_user.role != 'owner'
      existing_user.update!(role: 'owner')
      puts "✅ Updated role to Owner"
    end
  else
    # Create new super admin
    puts "🚀 Creating new Super Admin user..."
    
    super_admin = User.create!(
      email: SUPER_ADMIN_EMAIL,
      password: SUPER_ADMIN_PASSWORD,
      password_confirmation: SUPER_ADMIN_PASSWORD,
      role: 'owner'
    )
    
    puts "✅ SUCCESS! Super Admin created:"
    puts "📧 Email: #{super_admin.email}"
    puts "🔑 Password: #{SUPER_ADMIN_PASSWORD}"
    puts "👑 Role: #{super_admin.role_display}"
    puts "🔥 Super Admin?: #{super_admin.super_admin?}"
    
    # Test permissions
    puts "\n🛡️  PERMISSIONS TEST:"
    puts "  ✓ Can create users: #{super_admin.can_create_users?}"
    puts "  ✓ Can edit users: #{super_admin.can_edit_users?}"
    puts "  ✓ Can create admins: #{super_admin.can_create_admin?}"
    puts "  ✓ Can switch users: #{super_admin.super_admin?}"
  end
  
  # Show all users summary
  puts "\n📊 ALL USERS SUMMARY:"
  puts "-" * 50
  User.all.each do |user|
    status_icons = []
    status_icons << "👑" if user.owner?
    status_icons << "🔥" if user.super_admin?
    status_icons << "⚡" if user.admin?
    status_icons << "👤" if user.manager?
    
    puts "#{status_icons.join} #{user.email.ljust(30)} | #{user.role_display}"
  end
  
  puts "\n✨ Super Admin setup complete!"
  puts "🔗 You can now login with:"
  puts "   Email: #{SUPER_ADMIN_EMAIL}"
  puts "   Password: #{SUPER_ADMIN_PASSWORD}"
  
rescue => e
  puts "❌ ERROR creating Super Admin:"
  puts "   #{e.message}"
  
  if e.respond_to?(:record) && e.record&.errors&.any?
    puts "\n🔍 Validation Errors:"
    e.record.errors.full_messages.each do |error|
      puts "   - #{error}"
    end
  end
end

puts "="*50
puts "🏁 Script completed!"
puts "="*50 + "\n"








