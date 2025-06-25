module UriHelper
  def subscriptions_url(season: Config.first.season)
    "/secretariat/#{season.name}/eleves"
  end

  def teachers_url(season: Config.first.season)
    "/secretariat/#{season.name}/professeurs?status=0"
  end

  def instruments_url(season: Config.first.season)
    "/secretariat/#{season.name}/disciplines"
  end

  def kid_workshops_url(season: Config.first.season)
    "/secretariat/#{season.name}/enfance"
  end

  def workshops_url(season: Config.first.season)
    "/secretariat/#{season.name}/disciplines"
  end

  def payors_url(season: Config.first.season)
    "/secretariat/#{season.name}/foyers"
  end

  def student_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/eleves/#{record.id}"
  end

  def teacher_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/professeurs/#{record.id}"
  end

  def instrument_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/disciplines/#{record.id}"
  end

  def kid_workshop_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/enfance/#{record.id}"
  end

  def workshop_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/ateliers/#{record.id}"
  end

  def payor_url(season: Config.first.season, record:)
    "/secretariat/#{season.name}/foyers/#{record.id}"
  end
end
