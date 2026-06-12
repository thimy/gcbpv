# frozen_string_literal: true

class Website::Card::Workshop::Component < ViewComponent::Base
  with_collection_parameter :workshop

  def initialize(workshop:, path:)
    @workshop = workshop
    @path = path
    @season = Config.first.season
  end

  def teacher_names
    @workshop.workshop_slots.active(@season).collect{|slot| slot.teachers }.uniq.map { |teachers|
      teachers.collect{|teacher| teacher.name}
  }.flatten.uniq
  end
end
