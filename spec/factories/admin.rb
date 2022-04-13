FactoryBot.define do
  factory :admin do
    certifier
    first_name { 'John' }
    last_name { 'Smith' }
    email { 'jsmith@bikes-unlimited.com' }
    password { 'Password1!' }
  end
end