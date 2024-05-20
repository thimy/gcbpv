workshops = [{
  name: "Éveil musical",
  frequency: "1 séance de 45 minutes toutes les semaines",
  description: "Chant, danse, conte... à la découverte du patrimoine culturel local, de la musique traditionnelle pour les enfants de 4 à 6 ans.\r\n\r\nJeux rythmiques et mélodiques autour de la musique traditionnelle, chants, danses, contes, découverte d’instruments, participation à la P’tite Bogue notamment."
}, {
  name: "Découverte instrumentale",
  frequency: "1 séance de 45 minutes toutes les semaines",
  description: "Accompagnement de l’élève vers le choix d’un instrument de 7 à 9 ans.\r\n\r\nDécouverte et pratique de 5 instruments parmi les suivants : biniou-bombarde et cornemuse, clarinette, violon, guitare, flûtes (tin whistle, traversière...), accordéon diatonique, bodhran.\r\n\r\nJeux rythmiques et mélodiques autour de la musique traditionnelle, chants, danses, percussions corporelles, participation à la P’tite Bogue..."
}]

workshops.each do |workshop|
  KidWorkshop.create!(workshop)
end
