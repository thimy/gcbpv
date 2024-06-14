class Subscription < ActiveRecord::Migration[7.1]
  def change
    remove_reference :subbed_workshops, :workshop
    add_reference    :subbed_workshops, :workshop_slot

    remove_column    :subscriptions, :donation
  end
end
