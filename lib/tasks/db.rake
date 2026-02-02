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

  task migrate_admins: :environment do
    administrators = [{
      name: "Thimy KIEU",
      email: "thimy@pm.me",
      password: "De6ebrey",
      admin: true
    }, {
      name: "Fabienne MABON",
      email: "coordination@gcbpv.org",
      password: "Changez-moi",
      admin: true
    }, {
      name: "Laurence DAVID",
      email: "secretariat@gcbpv.org",
      password: "Changez-moi",
      admin: true
    }, {
      name: "Aurélie BRAULT",
      email: "archives@gcbpv.org",
      password: "Changez-moi",
      admin: true
    }]
    administrators.each do |admin|
      User.create!(admin)
    end

    User.find(25).update!(
      name: "Milly FELEZ",
      email: "ecole@gcbpv.org",
      password: "Changez-moi",
      admin: true
    )

    User.find(1).update!(
      name: "Goulven DRÉANO",
      admin: true
    )

    User.all.each do |user|
      name = user.teacher && user.teacher.name || user.student && user.student&.name || ""
      user.update!(name: name) if user.name.nil?
    end
  end

  task session_clear: :environment do
    ActiveRecord::SessionStore::Session.delete_all
  end

  task loans: :environment do
    Subscription.where.not(instrument_loan: [nil, ""]).each do |sub|
      loan = Loan.create!(instrument: sub.instrument_loan, subscription: sub)
      puts sub.instrument_loan
    end
  end

  task seasons: :environment do
    Season.all.each do |season|
      Course.all.each do |course|
        if course.subscription&.subscription_group&.season == season
          SlotSeason.create!(slot: course.slot, season: season) if SlotSeason.where(slot: course.slot, season: season).empty?
          InstrumentSeason.create!(instrument: course.instrument, season: season) if InstrumentSeason.where(instrument: course.instrument, season: season).empty?
          TeacherSeason.create!(teacher: course.slot.teacher, season: season) if TeacherSeason.where(teacher: course.slot.teacher, season: season).empty?
        end
      end
      SubbedWorkshop.all.each do |workshop|
        if workshop.subscription&.subscription_group&.season == season
          WorkshopSlotSeason.create!(workshop_slot: workshop.workshop_slot, season: season) if WorkshopSlotSeason.where(workshop_slot: workshop.workshop_slot, season: season).empty?
          WorkshopSeason.create!(workshop: workshop.workshop_slot&.workshop, season: season) if WorkshopSeason.where(workshop: workshop.workshop_slot&.workshop, season: season).empty?
        end
      end
    end
  end
end
