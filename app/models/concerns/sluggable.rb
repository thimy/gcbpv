module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug, on: :create

    def to_param
      slug
    end

    private

    def source_attribute
      self.class.source_attribute || :name
    end

    def generate_slug
      base_slug = send(source_attribute)&.to_s&.parameterize
      self.slug = unique_slug(base_slug) if slug.blank?
    end

    def unique_slug(base_slug)
      if self.class.exists?(slug: base_slug)
        "#{base_slug}-#{SecureRandom.hex(3)}"
      else
        base_slug
      end
    end
  end

  class_methods do
    attr_accessor :source_attribute

    def slugify(attribute)
      self.source_attribute = attribute
    end
  end
end
