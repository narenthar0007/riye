#!/usr/bin/env ruby

# Ruby code examples for creating API access keys programmatically
# This file contains various Ruby code snippets you can use in your Rails application

require_relative 'config/environment'

# Example 1: Create a basic API key with full access
def create_basic_api_key
  api_access = ApiAccess.create!(
    name: "Basic API Key",
    active: true
  )

  puts "Basic API Key Created:"
  puts "Access Key: #{api_access.access_key}"
  puts "Secret Key: #{api_access.secret_key}"
  puts "Permissions: Full access (no restrictions)"
end

# Example 2: Create API key for a specific user
def create_user_api_key(user_email)
  user = User.find_by(email: user_email)
  return puts "User not found: #{user_email}" unless user

  api_access = ApiAccess.create!(
    name: "User API Key for #{user.email}",
    user: user,
    active: true
  )

  puts "User API Key Created for #{user.email}:"
  puts "Access Key: #{api_access.access_key}"
  puts "Secret Key: #{api_access.secret_key}"
end

# Example 3: Create API key with limited permissions
def create_limited_api_key
  api_access = ApiAccess.create!(
    name: "Limited API Key",
    permissions: "attendances,workers,projects", # JSON array as string
    active: true
  )

  puts "Limited API Key Created:"
  puts "Access Key: #{api_access.access_key}"
  puts "Secret Key: #{api_access.secret_key}"
  puts "Permissions: #{api_access.permissions_array.join(', ')}"
end

# Example 4: Create API key with expiration date
def create_expiring_api_key
  api_access = ApiAccess.create!(
    name: "Temporary API Key",
    expires_at: 30.days.from_now,
    active: true
  )

  puts "Temporary API Key Created:"
  puts "Access Key: #{api_access.access_key}"
  puts "Secret Key: #{api_access.secret_key}"
  puts "Expires: #{api_access.expires_at}"
end

# Example 5: Create API key with all options
def create_full_featured_api_key
  user = User.find_by(email: "narenthar.bluvent@gmail.com")
  return puts "User not found" unless user

  api_access = ApiAccess.create!(
    name: "Full Featured API Key",
    user: user,
    permissions: "attendances,workers,projects,companies",
    expires_at: 1.year.from_now,
    active: true
  )

  puts "Full Featured API Key Created:"
  puts "Name: #{api_access.name}"
  puts "User: #{api_access.user.email}"
  puts "Access Key: #{api_access.access_key}"
  puts "Secret Key: #{api_access.secret_key}"
  puts "Permissions: #{api_access.permissions_array.join(', ')}"
  puts "Expires: #{api_access.expires_at}"
  puts "Active: #{api_access.active?}"
end

# Example 6: Bulk create API keys
def create_bulk_api_keys
  users = User.all.limit(5) # Get first 5 users

  users.each do |user|
    api_access = ApiAccess.create!(
      name: "Bulk API Key for #{user.email}",
      user: user,
      permissions: "attendances,workers",
      active: true
    )

    puts "Created API key for #{user.email}:"
    puts "  Access Key: #{api_access.access_key}"
    puts "  Secret Key: #{api_access.secret_key}"
    puts "---"
  end
end

# Example 7: Create API key in a Rails controller/service
class ApiKeyService
  def self.create_for_user(user, options = {})
    defaults = {
      name: "API Key for #{user.email}",
      permissions: nil, # nil means full access
      expires_at: nil,  # nil means never expires
      active: true
    }

    options = defaults.merge(options)

    api_access = ApiAccess.new(
      name: options[:name],
      user: user,
      permissions: options[:permissions],
      expires_at: options[:expires_at],
      active: options[:active]
    )

    if api_access.save
      {
        success: true,
        api_access: api_access,
        access_key: api_access.access_key,
        secret_key: api_access.secret_key
      }
    else
      {
        success: false,
        errors: api_access.errors.full_messages
      }
    end
  end
end

# Example usage of the service
def create_api_key_with_service
  user = User.find_by(email: "narenthar.bluvent@gmail.com")
  return puts "User not found" unless user

  result = ApiKeyService.create_for_user(user,
    name: "Service Created API Key",
    permissions: "attendances,workers",
    expires_at: 6.months.from_now
  )

  if result[:success]
    puts "API Key created successfully via service:"
    puts "Access Key: #{result[:access_key]}"
    puts "Secret Key: #{result[:secret_key]}"
  else
    puts "Failed to create API key: #{result[:errors].join(', ')}"
  end
end

# Run examples (uncomment the ones you want to test)
if __FILE__ == $0
  puts "=== Ruby API Key Creation Examples ===\n"

  # Uncomment any of these to test:
  # create_basic_api_key
  # create_user_api_key("narenthar.bluvent@gmail.com")
  # create_limited_api_key
  # create_expiring_api_key
  # create_full_featured_api_key
  # create_bulk_api_keys
  # create_api_key_with_service

  puts "\n=== Available Methods ==="
  puts "1. create_basic_api_key - Basic API key with full access"
  puts "2. create_user_api_key(email) - API key for specific user"
  puts "3. create_limited_api_key - API key with limited permissions"
  puts "4. create_expiring_api_key - API key with expiration date"
  puts "5. create_full_featured_api_key - API key with all options"
  puts "6. create_bulk_api_keys - Create multiple API keys"
  puts "7. create_api_key_with_service - Use service class"
end