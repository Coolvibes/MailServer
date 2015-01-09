FactoryGirl.define do

  factory :receiver do |f|

  	f.association :email , :factory => :email
    f.id {}
    f.receiver_email { "xyz@josh.com" }
    f.is_read {false}

  end

end