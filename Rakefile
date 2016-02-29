desc "Bootstraps the repo"
task :bootstrap do
  sh 'bundle'
  sh 'cd Example && bundle exec pod install'
end

desc "Runs the specs [EMPTY]"
task :spec do
  sh 'xcodebuild -workspace GSKStretchyHeaderView.xcworkspace -derivedDataPath "./build" -scheme \'Example\' -configuration Debug -destination platform=\'iOS Simulator\',OS=9.2,name=\'iPhone 5s\' clean build test -sdk iphonesimulator | xcpretty -sc && exit ${PIPESTATUS[0]}'
end
