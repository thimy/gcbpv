# frozen_string_literal: true

class Website::Card::Workshop::Component < ViewComponent::Base
  with_collection_parameter :workshop

  def initialize(workshop:, path:)
    @workshop = workshop
    @path = path
  end

  def teacher_names(slot)
    slot.teachers.map { |teacher|
      teacher.name
  }.join("/")
  end
end
