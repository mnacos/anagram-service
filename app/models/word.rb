class Word < ApplicationRecord
  validates :value, uniqueness: true

  before_save :update_profile

  def update_profile
    self.profile = self.class.profile self.value
  end

  def self.import_file(file_path, progress_bar=nil)
    File.open(file_path, "r").each_line do |word|
      create(value: word.chomp) && progress_bar && progress_bar.increment!
    end
  end

  def self.profile(supplied_string)
    sanitised_input = supplied_string.gsub(/[^[:alpha:]']/, '')
    keys = sanitised_input.scan(/./).uniq.sort
    keys.map { |k| "#{k}:#{sanitised_input.count k}" }.join(',')
  end

  def self.all_for_profile(supplied_string)
    self.where(profile: self.profile(supplied_string)).order('value').map(&:value)
  end

  def self.anagram(supplied_string)
    self.all_for_profile(supplied_string).reject { |s| s == supplied_string }
  end
end
