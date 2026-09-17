# == Schema Information
#
# Table name: subbed_pathways
#
#  id              :bigint           not null, primary key
#  comment         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  pathway_slot_id :bigint           not null
#  subscription_id :bigint           not null
#
# Indexes
#
#  index_subbed_pathways_on_pathway_slot_id  (pathway_slot_id)
#  index_subbed_pathways_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (pathway_slot_id => pathway_slots.id)
#  fk_rails_...  (subscription_id => subscriptions.id)
#
class SubbedPathway < ApplicationRecord
  belongs_to :pathway_slot
  belongs_to :subscription
end
