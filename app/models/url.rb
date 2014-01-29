require 'open-uri'
require 'debugger'

class Url < ActiveRecord::Base
  # Remember to create a migration!
  validate :valid_url
  validates :long_url, uniqueness: true
  validates :short_url, uniqueness: true
  belongs_to :user

  def valid_url
    uri = URI.parse(self.long_url)
    begin
     uri.request_uri
    rescue
      errors.add(:long_url, "not valid url")
    end
  end
end
