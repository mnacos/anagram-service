namespace :import do
  task wordlist: :environment do
    require 'progress_bar'
    filename = File.join(Rails.root, 'db/wordlist.txt')
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
    bar = ProgressBar.new(line_count)
    Word.import_file(filename, bar)
  end
end
