# frozen_string_literal: true

Fabricator(:user) do
  email { sequence(:email) { |i| "user_#{i}@test.com" } }
  password "cheikh"
end

Fabricator(:back_office, from: :user) do
  back_office true
end