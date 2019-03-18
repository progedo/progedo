Survey.delete_all

Survey.create!(title: 'Recensement de la population 2010 : fichier détail logements',
  abstract:
    %{Le fichier détail logements du recensement de la population de 2010 porte sur la localisation, les caractéristiques d'un logement ordinaire (catégorie, type de construction, confort, surface, nombre de pièces, etc…), et les caractéristiques sociodémographiques du ménage qui y réside. Les informations relatives au ménage sont fournies uniquement lorsque le logement est occupé au titre de la résidence principale. Les variables y sont disponibles avec des modalités détaillées, y compris les variables à diffusion restreinte (nationalité, pays de naissance, ancienneté d'arrivée en France). A partir de ce fichier, il est donc possible de faire des analyses exploratoires de données, de modéliser des comportements, ou simplement de tabuler sur une sous-population particulière définie selon certains critères : appartenance à une zone géographique et/ou unité statistique présentant certaines caractéristiques.

    })

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
