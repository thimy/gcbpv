class WebsiteController < ApplicationController
  def index
    @posts = Post.latest.limit(3) 
    @events = Event.ordered.upcoming.limit(5).reverse
    render layout: "home"
  end

  def not_found
    if request.host != ENV.fetch("APPLICATION_HOST") &&
        !request.original_fullpath.start_with?("//") # Prevent open-redirect vulnerability
      begin
        redirect_to URI.join(root_url, request.original_fullpath).to_s
      rescue URI::InvalidURIError
        redirect_to URI.join(root_url, CGI.escape(request.original_fullpath)).to_s
      end
    else
      # "formats: :html" is used to avoid 500 for custom_domain//unknown.xml
      # =>Missing template pages/not_found, application/not_found with { :formats=>[:xml], ...
      render(status: 404, formats: :html)
    end
  end
end
