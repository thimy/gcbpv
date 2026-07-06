class Subscription < ApplicationRecord
  include GenerateCsv
  
  belongs_to :student
  has_one :loan
  has_many :courses
  has_many :instrument, through: :courses
  has_many :subbed_pathways
  has_many :pathway_slots, through: :subbed_pathways
  has_many :kid_workshop_slots, through: :subbed_kid_workshops
  has_many :subbed_workshops, dependent: :destroy
  has_many :workshop_slots, through: :subbed_workshops
  has_many :workshops, through: :workshop_slots
  belongs_to :subscription_group
  delegate :season, to: :subscription_group
  delegate :household, to: :subscription_group
  delegate :plan, to: :subscription_group
  delegate :majoration_class, to: :subscription_group

  validate :student_unique_subscription, on: :create
  validates :subscription_group, presence: true

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :workshop_slots, :loan, allow_destroy: true

  STATUSES = {
    INQUIRY: "Demande d’information",
    REGISTERED: "Inscrit",
    CANCELED: "Annulé"
    # ON_HOLD: "Dans le panier"
  }

  PRICES = {
    "Redon Agglo": {
      class: "class_price",
      kids_class: "kids_class_price",
      class_double_workshops: "class_double_workshop_price",
      kids_class_double_workshops: "kid_class_double_workshop_price",
      workshop: "workshop_price",
      kid_workshop: "kid_workshop_price",
      double_workshops: "double_workshop_price",
      kids_double_workshops: "kid_double_workshop_price",
    },
    "Oust à Brocéliande Communauté": {
      class: "class_price_obc",
      kids_class: "kids_class_price_obc",
      class_double_workshops: "class_double_workshop_price_obc",
      kids_class_double_workshops: "kid_class_double_workshop_price_obc",
      workshop: "workshop_price_obc",
      kid_workshop: "kid_workshop_price_obc",
      double_workshops: "double_workshop_price_obc",
      kids_double_workshops: "kid_double_workshop_price_obc",
      markup_name: "obc_markup"
    },
    "Hors agglo": {
      class: "class_price_outbounds",
      kids_class: "kids_class_price_outbounds",
      class_double_workshops: "class_double_workshop_price_outbounds",
      workshop: "workshop_price_outbounds",
      kid_workshop: "kid_workshop_price_outbounds",
      kids_class_double_workshops: "kid_class_double_workshop_price_outbounds",
      double_workshops: "double_workshop_price_outbounds",
      kids_double_workshops: "kid_double_workshop_price_outbounds",
      markup_name: "outbounds_markup"
    }
  }

  enum :status, {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2
  }

  scope :active, ->(season) {includes(:subscription_group).where(subscription_group: { season: season })}
  scope :not_on_hold, -> {where.not(subscription_group: SubscriptionGroup.where(status: "Dans le panier"))}
  scope :registered, ->(season) {active(season).where.not(status: [nil, 0])}
  scope :inquired, ->(season) {active(season).where(status: 0)}
  scope :has_optional_workshop, ->(workshop) { where(subbed_workshops.optional.has_workshop(workshop)) }
  scope :has_confirmed_workshop, ->(workshop) { where(subbed_workshops.confirmed.has_workshop(workshop)) }
  scope :has_optional_kid_workshop, ->(workshop) { where(subbed_workshops.optional.has_kid_workshop(workshop)) }
  scope :has_confirmed_kid_workshop, ->(workshop) { where(subbed_workshops.confirme.has_kid_workshop(workshop)) }
  scope :latest, -> {order(created_at: :desc)}

  scope :youth, -> { student.birth_year > (subscription_group.season.start_year - 18) }
  scope :adults, -> { includes(:student).where(Student.adults) }
  scope :undefined_age, -> { includes(:student).where(student: Student.undefined_age) }

  def is_youth?
    student.birth_year > (subscription_group.season.start_year - 18)
  end

  def student_unique_subscription
    if student.subscriptions.active(subscription_group.season).size > 0
      errors.add(:base, "L’élève est déjà inscrit pour cette année.")
    end
  end

  def kid_workshop_list
    workshop_slots.youth.map {|slot|
      slot.workshop.name
  }.join(", ")
  end

  def course_list
    courses.map {|course|
      course.instrument.name
  }.join(", ")
  end

  def workshop_list
    workshop_slots.adults.map {|slot|
      slot.workshop.name
  }.join(", ")
  end

  def pathway_list
    pathway_slots.map {|slot|
      slot.pathway.name
  }.join(", ")
  end

  def address
    student.address.presence || subscription_group&.household&.address
  end

  def phone
    student.phone&.phony_formatted(normalize: :FR) || subscription_group.household.phones
  end

  def email
    student.email.presence || subscription_group.household.emails
  end

  def postcode
    student.postcode.presence || subscription_group&.household&.postcode
  end

  def city
    student.city.presence || subscription_group.household.city
  end

  def optional?
    ["Demande d’information", "Annulé"].include?(status)
  end

  def optional_course?(instrument)
    courses.find_by(instrument: instrument).option == "Optionel"
  end

  def optional_workshop?(workshop)
    subbed_workshops.includes(:workshop_slot).find_by(workshop_slot: {workshop: workshop}).option == "Optionel"
  end

  def optional_kid_workshop?(workshop)
    subbed_workshops.youth.includes(:workshop_slot).find_by(workshop_slot: {workshop: workshop}).option == "Optionel"
  end

  def loan_cost
    loan.presence.cost
  end

  def total_cost
    items.map { |item| item[:price] }.compact.sum
  end

  def payment_state
    status != "Inscrit" ? status : subscription_group.payment_state
  end

  def course_workshop_diff
    subbed_workshops.adults.confirmed.size - courses.confirmed.size
  end

  def has_class_extra_workshops?
    course_workshop_diff > 0
  end

  def items
    get_items
  end

  private

  def get_items
    items = []
    courses.confirmed.each_with_index do |course, index|
      items[index] = {:course => course}
    end
    subbed_workshops.adults.confirmed.sort_by{|workshop| workshop.price}.each_with_index do |workshop, index|
      if plan.class_double_workshop_price.present?
        if index < courses.size * 2
          if index - 1 < items.size
            items[index - 1].present? && items[index - 1][:workshops].present? ? items[index - 1][:workshops].push(workshop) : items[index][:workshops] = [workshop]
          else
            items[(index / 2).floor][:workshops].push(workshop)
          end
        else
          current_item_index = items.size - 1
          if items[current_item_index].present? && items[current_item_index][:workshops].size < 2
            items[current_item_index][:workshops].push(workshop)
          else
            items[items.size] = {:workshops => [workshop]}
          end
        end
      else
        if index < courses.size && index < items.size + 1
          items[index].present? && items[index][:workshops].present? ? items[index][:workshops].push(workshop) : items[index][:workshops] = [workshop]
        else
          items[items.size] = {:workshops => [workshop]}
        end
      end
    end
    subbed_workshops.youth.confirmed.each do |workshop|
      items[items.size] = {:kid_workshop => workshop}
    end

    price_class = PRICES[subscription_group.majoration_class.to_sym]
    items.each do |item|
      if item[:kid_workshop].present?
        item[:price] = item[:kid_workshop].price
      elsif item[:workshops]&.size == 2
        if item[:course].present?
          item[:price] = is_youth? ? plan[price_class[:kids_class_double_workshops]] : plan[price_class[:class_double_workshops]]
        else
          item[:price] = is_youth? ? plan[price_class[:kids_double_workshops]] : plan[price_class[:double_workshops]]
        end
      else
        if item[:course].present?
          item[:price] = is_youth? ? plan[price_class[:kids_class]] : plan[price_class[:class]]
        else
          if item[:workshops].size == 1
            item[:price] = item[:workshops].first.price
          else
            item[:price] = is_youth? ? plan[price_class[:kid_workshop]] : plan[price_class[:workshop]]
          end
        end
      end
    end
    items
  end
end
