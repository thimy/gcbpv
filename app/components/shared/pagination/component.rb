class Shared::Pagination::Component < ViewComponent::Base
  delegate :pagy_link_proc, :inline_svg, to: :helpers

  def initialize(pagy:, resource_name:)
    @pagy = pagy
    @resource_name = resource_name
  end

  def render?
    @pagy.vars[:count] > @pagy.vars[:items]
  end
end
