class SponsorDonation < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :event
end
