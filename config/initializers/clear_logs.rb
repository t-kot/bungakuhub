if Rails.env.development? || Rails.env.test?
  MAX_LOG_SIZE = 20.megabytes
  logs = File.join(Rails.root, 'log', '*.log')
  if Dir[logs].any? {|log| File.size?(log).to_i > MAX_LOG_SIZE }
    $stdout.puts "Runnning rake log:clear"
    `rake log:clear`
  end
end
