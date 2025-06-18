module WithPerson
  extend ActiveSupport::Concern

  def first_name=(value)
    super(value.to_s.squish.upcase)
  end

  def last_name=(value)
    super(value.to_s.squish.upcase)
  end
end
