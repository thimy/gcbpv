# frozen_string_literal: true

class Website::Card::Workshop::Component < ViewComponent::Base
  with_collection_parameter :workshop

  def initialize(workshop:, path:)
    @workshop = workshop
    @path = path
  end

  def teacher_names
    @workshop.workshop_slots.active.collect{|slot| slot.teachers }.uniq.map { |teachers|
      teachers.collect{|teacher| teacher.name}
  }.flatten.uniq
  end
end
