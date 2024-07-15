require "administrate/custom_dashboard"

class FichesProfDashboard < Administrate::CustomDashboard
  resource "FichesProfs" # used by administrate in the views
end
