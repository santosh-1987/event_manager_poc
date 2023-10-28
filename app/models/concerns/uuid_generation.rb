module UuidGeneration
  extend ActiveSupport::Concern

  included do
    before_validation :generate_id
  end

  private

  def generate_id
    self[:id] = UUIDv6.uuid unless self[:id]
  end
end