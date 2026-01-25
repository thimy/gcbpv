class ApplicationDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def self.filter_attributes(*args)
    options = args.extract_options!
    [*args].each do |attr|
      define_method attr do
        h.send(options.fetch(:with), model.send(attr))
      end
    end
  end
end
