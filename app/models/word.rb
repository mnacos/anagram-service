class Word < ApplicationRecord
  validates :value, uniqueness: true

  def self.import_file(file_path, progress_bar=nil)
    File.open(file_path, "r").each_line do |word|
      create(value: word) && progress_bar && progress_bar.increment!
    end
  end

  def self.anagram(supplied_string)
    []
  end
end
