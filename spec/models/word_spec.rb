require 'rails_helper'

RSpec.describe Word, type: :model do
  before(:each) { @word = Word.new(value: 'kinship') }

  it { expect(@word).to respond_to(:value) }
  it { expect(@word).to respond_to(:profile) }

  context "[object lifecycle]" do
    it "auto-generates a letter profile on save" do
      expect(@word.profile).to be_nil
      @word.save
      expect(@word.profile).not_to be_nil
    end

    it "generates the profile using ordered character frequencies" do
      expected_profile_string = "h:1,i:2,k:1,n:1,p:1,s:1"
      @word.save
      expect(@word.profile).to eq(expected_profile_string)
    end
  end

  context "[database maintenance]" do
    it "validates the uniqueness of :value" do
      @word.save
      new_word = Word.new(value: 'kinship')
      expect(new_word).not_to be_valid
    end

    it "allows batch import of words from a text file" do
      Word.import_file File.join(Rails.root, 'spec/fixtures/files/wordlist.txt')
      expect(Word.count).to eq(100)
    end
  end

  context "[query interface]" do
    before(:each) do
      Word.create(value: 'pinkish')
      Word.create(value: 'kinship')
      Word.create(value: 'unrelated')
    end

    it "can generate a letter profile for any supplied string" do
      expected_profile_string = "h:1,i:2,k:1,n:1,p:1,s:1"
      expect(Word.profile 'pinkish').to eq(expected_profile_string)
    end

    it "can find all words in the database for a given letter profile" do
      matching_words = ['kinship', 'pinkish']
      expect(Word.all_for_profile 'pinkish').to eq(matching_words)
    end

    it "excludes the original word for the list of results" do
      matching_words = ['kinship']
      expect(Word.anagram 'pinkish').to eq(matching_words)
    end

    it "returns nil if the supplied string does not a match a word in the database" do
      expect(Word.anagram 'derp').to be_nil
    end
  end

  context "[performance]", performance: true do
    require 'benchmark'

    it "anagram searches in a scalable way, independent of dictionary size" do
      100.times { Word.create(value: rand.to_s) }
      time100 = Benchmark.measure { Word.anagram 'pinkish' }
      expect(time100.real).to be < 3.0

      1000.times { Word.create(value: rand.to_s) }
      time1000 = Benchmark.measure { Word.anagram 'pinkish' }
      expect(time1000.real).to be < 3.0

      10000.times { Word.create(value: rand.to_s) }
      time10000 = Benchmark.measure { Word.anagram 'pinkish' }
      expect(time10000.real).to be < 3.0
    end
  end
end
