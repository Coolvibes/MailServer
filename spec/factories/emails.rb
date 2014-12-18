
require 'faker'

 FactoryGirl.define do

  factory :email do |f|
    f.sender { "xyz@josh.com" }
    f.subject { ""}
    f.message { "hghqgdh" }
    f.is_draft {true}
  end

end
