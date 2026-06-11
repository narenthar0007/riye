module ApplicationHelper
  # Common button helper with consistent styling
  def riye_button(text, path, options = {})
    # Default options
    defaults = {
      color: 'primary',
      size: 'md',
      icon: nil,
      outline: false,
      block: false,
      disabled: false,
      confirm: nil,
      method: :get,
      title: text,
      class: '',
      id: nil,
      data: {}
    }
    
    opts = defaults.merge(options)
    
    # Build CSS classes
    css_classes = ['riye-btn']
    
    if opts[:outline]
      css_classes << "riye-btn-outline-#{opts[:color]}"
    else
      css_classes << "riye-btn-#{opts[:color]}"
    end
    
    css_classes << "riye-btn-#{opts[:size]}"
    css_classes << 'riye-btn-block' if opts[:block]
    css_classes << 'disabled' if opts[:disabled]
    css_classes << opts[:class] if opts[:class].present?
    
    # Build button content
    content = ""
    content += "<i class=\"#{opts[:icon]}\"></i> " if opts[:icon]
    content += text
    
    # Build link options
    link_options = {
      class: css_classes.join(' '),
      title: opts[:title],
      method: opts[:method],
      data: opts[:data]
    }
    
    link_options[:id] = opts[:id] if opts[:id]
    link_options[:confirm] = opts[:confirm] if opts[:confirm]
    
    link_to content.html_safe, path, link_options
  end

  def get_create_button_data(controller_name)
    case controller_name
    when 'workers'
      { 
        path: new_worker_path, 
        text: 'New Worker', 
        title: 'Add New Worker' 
      }
    when 'teams'
      { 
        path: new_team_path, 
        text: 'New Team', 
        title: 'Create New Team' 
      }
    when 'team_heads'
      { 
        path: new_team_head_path, 
        text: 'New Team Head', 
        title: 'Add New Team Head' 
      }
    when 'users'
      return nil unless current_user&.can_create_users?
      { 
        path: new_user_path, 
        text: 'New User', 
        title: 'Create New User' 
      }
    when 'projects'
      { 
        path: new_project_path, 
        text: 'New Project', 
        title: 'Create New Project' 
      }
    when 'companies'
      { 
        path: new_company_path, 
        text: 'New Company', 
        title: 'Add New Company' 
      }
    when 'stocks'
      { 
        path: new_stock_path, 
        text: 'New Stock Item', 
        title: 'Add New Stock Item' 
      }
    when 'daily_updates'
      { 
        path: new_daily_update_path, 
        text: 'New Update', 
        title: 'Create Daily Update' 
      }
    when 'bank_details'
      # Bank details are usually created through worker context
      nil
    when 'attendances'
      # Attendance is typically managed differently
      nil
    else
      nil
    end
  end

  def page_title_with_icon(controller_name)
    case controller_name
    when 'home'
      { icon: 'fas fa-home', title: 'Dashboard', subtitle: 'Overview and quick actions' }
    when 'workers'
      { icon: 'fas fa-users', title: 'Workers Management', subtitle: 'Manage your workforce and team assignments' }
    when 'teams'
      { icon: 'fas fa-users-cog', title: 'Teams Management', subtitle: 'Organize and manage your teams' }
    when 'team_heads'
      { icon: 'fas fa-user-tie', title: 'Team Heads Management', subtitle: 'Manage team leaders and supervisors' }
    when 'users'
      { icon: 'fas fa-users-cog', title: 'Users Management', subtitle: 'Manage user accounts and roles' }
    when 'bank_details'
      { icon: 'fas fa-university', title: 'Bank Details', subtitle: 'Manage banking information' }
    when 'projects'
      { icon: 'fas fa-project-diagram', title: 'Projects Management', subtitle: 'Track and manage construction projects' }
    when 'companies'
      { icon: 'fas fa-building', title: 'Companies Management', subtitle: 'Manage client companies and contractors' }
    when 'attendances'
      { icon: 'fas fa-clock', title: 'Attendance Management', subtitle: 'Track worker attendance and hours' }
    when 'stocks'
      { icon: 'fas fa-boxes', title: 'Stock Management', subtitle: 'Manage inventory and materials' }
    when 'daily_updates'
      { icon: 'fas fa-clipboard-list', title: 'Daily Updates', subtitle: 'Track daily progress and activities' }
    else
      { icon: 'fas fa-cog', title: controller_name.humanize, subtitle: 'Manage system settings' }
    end
  end
end
