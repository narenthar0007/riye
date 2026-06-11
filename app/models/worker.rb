class Worker < ApplicationRecord
  belongs_to :project
  belongs_to :team, optional: true
  belongs_to :head_worker, class_name: "Worker", optional: true
  has_many :subordinates, class_name: "Worker", foreign_key: "head_worker_id", dependent: :nullify
  has_many :attendances, dependent: :destroy
  has_one :bank_detail, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :contact, presence: true, uniqueness: { scope: :project_id, message: "can only be used once per project" }
  
  # Only add worker_id validations if the column exists (for migration compatibility)
  begin
    if table_exists? && column_names.include?('worker_id')
      validates :worker_id, presence: true, uniqueness: true, format: { with: /\AW\d+\z/, message: "must start with W followed by numbers" }
      before_validation :generate_worker_id, on: :create
    end
  rescue => e
    # Ignore errors during migrations or when table doesn't exist
  end

  # Define nature_of_worker enum if column exists (for migration compatibility)
  begin
    if table_exists? && column_names.include?('nature_of_worker')
      enum nature_of_worker: { regular: 0, head: 1, supervisor: 2 }
    end
  rescue => e
    # Ignore errors during migrations or when table doesn't exist
  end

  # Scopes that depend on columns existing
  begin
    if table_exists? && column_names.include?('head_worker_id')
      scope :heads, -> { where(head_worker_id: nil) }
      scope :subordinates_of, ->(head) { where(head_worker_id: head.id) }
    end
  rescue => e
    # Ignore errors during migrations or when table doesn't exist
  end

  def is_head?
    return false unless self.class.column_names.include?('head_worker_id')
    head_worker_id.nil?
  end

  def subordinate_count
    return 0 unless self.class.column_names.include?('head_worker_id')
    subordinates.count
  end

  def hierarchy_level
    return 0 unless self.class.column_names.include?('head_worker_id')
    level = 0
    current_worker = self
    while current_worker.head_worker.present?
      level += 1
      current_worker = current_worker.head_worker
      break if level > 10 # Prevent infinite loops
    end
    level
  end

  def top_head
    return self unless self.class.column_names.include?('head_worker_id')
    current_worker = self
    while current_worker.head_worker.present?
      current_worker = current_worker.head_worker
      break if current_worker == self # Prevent infinite loops
    end
    current_worker
  end

  private

  def generate_worker_id
    return unless self.class.column_names.include?('worker_id')
    return if worker_id.present?
    
    # Find the highest existing worker_id number
    last_worker = Worker.where("worker_id ~ ?", '^W\d+$')
                       .order(Arel.sql("CAST(SUBSTRING(worker_id FROM 2) AS INTEGER) DESC"))
                       .first

    if last_worker&.worker_id
      last_number = last_worker.worker_id[1..-1].to_i
      next_number = last_number + 1
    else
      next_number = 1000
    end

    self.worker_id = "W#{next_number}"
  end
end
