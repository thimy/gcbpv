class FixPathway < ActiveRecord::Migration[7.1]
  def change
    remove_reference :pathway_slot_teachers, :pathway
    add_reference    :pathway_slot_teachers, :pathway_slot
  end
end
