desc 'Run tests'
task :test do
  formatter = ''
  unless `which xcpretty`.chomp.empty?
    formatter = '| xcpretty'
  end

  sh "xcodebuild test -scheme MarkdownKit -destination 'platform=iOS Simulator,OS=13.5,name=iPhone 11' #{formatter}"
end

task :default => :test
