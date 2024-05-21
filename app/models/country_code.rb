class CountryCode < ApplicationRecord
  def display_name
    "#{flag} #{name} (#{code})"
  end
end
