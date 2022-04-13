FactoryBot.define do
  factory :rider do
    import
    first_name { 'John' }
    last_name { 'Smith' }
    email { 'somerider@bikes-unlimited.com' }
  end
end