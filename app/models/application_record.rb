class ApplicationRecord < ActiveRecord::Base
  include UuidGeneration

  primary_abstract_class

  self.abstract_class = true

  before_validation :generate_id, on: :create
  validate :valid_id

  # Internal: Returns an error if UUID is not valid.
  def valid_id
    errors.add(:id, "#{id} should be a UUID") if id.present? && UUID.validate(id).nil?
  end
end
