namespace :db do
  task merge_workshops: :environment do
    puts "Workshop count: #{KidWorkshop.all.count}"
    KidWorkshop.all.each do |workshop|
      new_workshop = Workshop.create!({
        name: workshop.name,
        description: workshop.description,
        status: workshop.status,
        comment: workshop.comment,
        kid_workshop_type: workshop.workshop_type,
        is_youth: true
      })

      puts "Workshop id: #{workshop.id}"
      KidWorkshopSlot.where(kid_workshop_id: workshop.id).each do |slot|
        new_slot = WorkshopSlot.create!({
          workshop_id: new_workshop.id,
          city_id: slot.city_id,
          slot_time: slot.slot_time,
          day_of_week: slot.day_of_week,
          frequency: slot.frequency,
          status: slot.status,
          comment: slot.comment
        })

        puts "Slot id: #{slot.id}"
        SubbedKidWorkshop.where(kid_workshop_slot_id: slot.id).each do |sub|
          new_sub = SubbedWorkshop.create!({
            workshop_slot_id: new_slot.id,
            subscription_id: sub.subscription_id,
            comment: sub.comment,
            option: sub.option
          })
        end
      end
    end
    puts Workshop.count
  end

  task fix_workshop_type: :environment do
    KidWorkshop.all.each do |workshop|
      workshop.update!(workshop_type: workshop.kid_workshop_type)
    end
  end

  task update_majoration_class: :environment do
    SubscriptionGroup.where(majoration_class: nil).each do |group|
      group.update!(majoration_class: group.household.agglo)
    end
  end
end
