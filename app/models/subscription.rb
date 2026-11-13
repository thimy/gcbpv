# == Schema Information
#
# Table name: subscriptions
#
#  id                    :bigint           not null, primary key
#  ars                   :boolean
#  comment               :text
#  disability            :boolean
#  image_consent         :boolean
#  instrument_loan       :string
#  status                :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  student_id            :bigint           not null
#  subscription_group_id :bigint
#
# Indexes
#
#  index_subscriptions_on_student_id             (student_id)
#  index_subscriptions_on_subscription_group_id  (subscription_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class Subscription < ApplicationRecord
  include GenerateCsv

  belongs_to :student, inverse_of: :subscriptions
  has_one :loan
  has_many :courses, inverse_of: :subscription
  has_many :instrument, through: :courses, inverse_of: :subscriptions
  has_many :subbed_pathways
  has_many :pathway_slots, through: :subbed_pathways
  has_many :kid_workshop_slots, through: :subbed_kid_workshops, inverse_of: :subscriptions
  has_many :subbed_workshops, dependent: :destroy, inverse_of: :subscription
  has_many :registered_subbed_workshops, -> { where.not(subscription: { status: [nil, 0] }).confirmed }, dependent: :destroy, inverse_of: :subscription
  has_many :workshop_slots, through: :subbed_workshops, inverse_of: :subscriptions
  has_many :workshops, through: :workshop_slots, inverse_of: :subscriptions
  belongs_to :subscription_group, inverse_of: :subscriptions
  delegate :season, to: :subscription_group
  delegate :household, to: :subscription_group
  delegate :plan, to: :subscription_group
  delegate :majoration_class, to: :subscription_group

  validate :student_unique_subscription, on: :create
  validates :subscription_group, presence: true

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :workshop_slots, :loan, allow_destroy: true

  STATUSES = {
    INQUIRY: 'Demande d’information',
    REGISTERED: 'Inscrit',
    CANCELED: 'Annulé'
  }.freeze

  PRICES = {
    "Redon Agglo": {
      class: 'class_price',
      kids_class: 'kids_class_price',
      class_double_workshops: 'class_double_workshop_price',
      kids_class_double_workshops: 'kid_class_double_workshop_price',
      workshop: 'workshop_price',
      kid_workshop: 'kid_workshop_price',
      double_workshops: 'double_workshop_price',
      kids_double_workshops: 'kid_double_workshop_price'
    },
    "Oust à Brocéliande Communauté": {
      class: 'class_price_obc',
      kids_class: 'kids_class_price_obc',
      class_double_workshops: 'class_double_workshop_price_obc',
      kids_class_double_workshops: 'kid_class_double_workshop_price_obc',
      workshop: 'workshop_price_obc',
      kid_workshop: 'kid_workshop_price_obc',
      double_workshops: 'double_workshop_price_obc',
      kids_double_workshops: 'kid_double_workshop_price_obc',
      markup_name: 'obc_markup'
    },
    "Hors agglo": {
      class: 'class_price_outbounds',
      kids_class: 'kids_class_price_outbounds',
      class_double_workshops: 'class_double_workshop_price_outbounds',
      workshop: 'workshop_price_outbounds',
      kid_workshop: 'kid_workshop_price_outbounds',
      kids_class_double_workshops: 'kid_class_double_workshop_price_outbounds',
      double_workshops: 'double_workshop_price_outbounds',
      kids_double_workshops: 'kid_double_workshop_price_outbounds',
      markup_name: 'outbounds_markup'
    }
  }.freeze

  enum :status, {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2
  }

  default_scope { order(created_at: :desc) }
  scope :active, ->(season) { includes(:subscription_group).where(subscription_group: { season: season }) }
  scope :not_on_hold, -> { where.not(subscription_group: SubscriptionGroup.where(status: 'Dans le panier')) }
  scope :confirmed, -> { where.not(status: [nil, 0]) }
  scope :registered, ->(season) { active(season).confirmed }
  scope :not_canceled, -> { where.not(status: 2) }
  scope :inquired, ->(season) { active(season).where(status: 0) }

  scope :youth, -> { student.birth_year > (subscription_group.season.start_year - 18) }
  scope :adults, -> { includes(:student).where(Student.adults) }
  scope :undefined_age, -> { includes(:student).where(student: Student.undefined_age) }

  def youth?
    @youth ||= student.birth_year > (subscription_group.season.start_year - 18)
  end

  def student_unique_subscription
    return if !student.subscriptions.active(subscription_group.season).empty?

    errors.add(:base, 'L’élève est déjà inscrit pour cette année.')
  end

  def kid_workshop_list
    @kid_workshop_list ||= workshop_slots.youth.map { it.workshop.name }.join(', ')
  end

  def course_list
    @course_list ||= courses.includes(:instrument).map { it.instrument.name }.join(', ')
  end

  def workshop_list
    @workshop_list ||= workshop_slots.includes(:workshop).adults.map { it.workshop.name }.join(', ')
  end

  def pathway_list
    @pathway_list ||= pathway_slots.includes(:pathway).map { it.pathway.name }.join(', ')
  end

  def address
    @address ||= tudent.address.presence || subscription_group&.household&.address
  end

  def phone
    @phone ||= student.phone&.phony_formatted(normalize: :FR) || subscription_group&.household&.phones
  end

  def email
    @email ||= student.email.presence || subscription_group&.household&.emails
  end

  def postcode
    @postcode ||= student.postcode.presence || subscription_group&.household&.postcode
  end

  def city
    @city ||= student.city.presence || subscription_group&.household&.city
  end

  def optional?
    @optional ||= ['Demande d’information', 'Annulé'].include?(status)
  end

  def optional_course?(instrument)
    courses.find_by(instrument: instrument).option == 'Optionel'
  end

  def optional_workshop?(workshop)
    subbed_workshops.includes(:workshop_slot).find_by(workshop_slot: { workshop: workshop }).option == 'Optionel'
  end

  def optional_kid_workshop?(workshop)
    subbed_workshops.youth.includes(:workshop_slot).find_by(workshop_slot: { workshop: workshop }).option == 'Optionel'
  end

  def loan_cost
    @loan_cost ||= loan.presence.cost
  end

  def total_cost
    @total_cost ||= items.map { |item| item[:price] }.compact.sum
  end

  def payment_state
    @payment_state ||= status != 'Inscrit' ? status : subscription_group.payment_state
  end

  def items
    @items ||= get_items
  end

  private

  def get_items
    items = []
    courses.confirmed.each_with_index do |course, index|
      items[index] = { course: course }
    end
    subbed_workshops.adults.confirmed.sort_by { it.price }.each_with_index do |workshop, index|
      if plan.class_double_workshop_price.present?
        if index < courses.size * 2
          if index - 1 < items.size
            if items[index - 1].present? && items[index - 1][:workshops].present?
              items[index - 1][:workshops].push(workshop)
            else
              items[index][:workshops] =
                [workshop]
            end
          else
            items[(index / 2).floor][:workshops].push(workshop)
          end
        else
          current_item_index = items.size - 1
          if items[current_item_index].present? && items[current_item_index][:workshops].size < 2
            items[current_item_index][:workshops].push(workshop)
          else
            items[items.size] = { workshops: [workshop] }
          end
        end
      elsif index < courses.size && index < items.size + 1
        if items[index].present? && items[index][:workshops].present?
          items[index][:workshops].push(workshop)
        else
          items[index][:workshops] = [workshop]
        end
      else
        items[items.size] = { workshops: [workshop] }
      end
    end
    subbed_workshops.youth.confirmed.each { |workshop| items[items.size] = { kid_workshop: workshop } }

    price_class = PRICES[subscription_group.majoration_class.to_sym]
    items.each do |item|
      if item[:kid_workshop].present?
        item[:price] = item[:kid_workshop].price
      elsif item[:workshops]&.size == 2
        if item[:course].present?
          item[:price] =
            youth? ? plan[price_class[:kids_class_double_workshops]] : plan[price_class[:class_double_workshops]]
        else
          item[:price] = youth? ? plan[price_class[:kids_double_workshops]] : plan[price_class[:double_workshops]]
        end
      elsif item[:course].present?
        item[:price] = youth? ? plan[price_class[:kids_class]] : plan[price_class[:class]]
      else
        item[:price] = if item[:workshops].size == 1
          item[:workshops].first.price
        else
          youth? ? plan[price_class[:kid_workshop]] : plan[price_class[:workshop]]
        end
      end
    end
    items
  end
end
