json.extract! survey, :id, :title, :abstract, :created_at, :updated_at
json.url survey_url(survey, format: :json)
