class UpdateTeamsToReferenceTeamHeads < ActiveRecord::Migration[8.0]
  def up
    # Add reference to team_heads
    add_reference :teams, :team_head, foreign_key: true

    # Data migration: Create TeamHead records from existing team_lead workers using raw SQL
    # This approach avoids loading the Worker model during migration
    
    # Get team data with their worker leads
    teams_data = connection.select_all(
      "SELECT t.id as team_id, t.team_lead_id, w.name, w.contact 
       FROM teams t 
       LEFT JOIN workers w ON t.team_lead_id = w.id 
       WHERE t.team_lead_id IS NOT NULL"
    )
    
    teams_data.each do |team_data|
      if team_data['name'].present?
        # Create team head
        dob_date = 30.years.ago.to_date.strftime('%Y-%m-%d')
        current_time = Time.current.strftime('%Y-%m-%d %H:%M:%S')
        
        team_head_id = connection.insert(
          "INSERT INTO team_heads (name, contact_number, age, gender, address, aadhaar_number, dob, created_at, updated_at) 
           VALUES (#{connection.quote(team_data['name'])}, 
                   #{connection.quote(team_data['contact'])}, 
                   30, 
                   'Male', 
                   'Please update address', 
                   #{connection.quote(generate_dummy_aadhaar)}, 
                   #{connection.quote(dob_date)}, 
                   #{connection.quote(current_time)}, 
                   #{connection.quote(current_time)})"
        )
        
        # Update team with team_head_id
        connection.execute(
          "UPDATE teams SET team_head_id = #{team_head_id} WHERE id = #{team_data['team_id']}"
        )
      end
    end

    # Remove the old team_lead_id column
    remove_foreign_key :teams, :workers, column: :team_lead_id
    remove_column :teams, :team_lead_id
  end

  def down
    # Add back the team_lead_id column
    add_reference :teams, :team_lead, foreign_key: { to_table: :workers }

    # Data migration back: This would be complex and lossy
    # For simplicity, we'll just remove team_head reference
    remove_reference :teams, :team_head
  end

  private

  def generate_dummy_aadhaar
    # Generate a unique dummy Aadhaar number (12 digits) using raw SQL
    loop do
      dummy_aadhaar = rand(100000000000..999999999999).to_s
      existing = connection.select_value(
        "SELECT COUNT(*) FROM team_heads WHERE aadhaar_number = #{connection.quote(dummy_aadhaar)}"
      )
      break dummy_aadhaar if existing.to_i == 0
    end
  end
end
