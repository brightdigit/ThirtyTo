#!/bin/bash

if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  swiftformat --lint . && swiftlint --quiet
else
  # What to do in Ubunutu
  export PATH="${PWD}/swift-5.1.3-RELEASE-ubuntu18.04/usr/bin:$PATH"
fi

swift build
swift test  --enable-code-coverage

if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  xcrun llvm-cov export -format="lcov" .build/debug/${FRAMEWORK_NAME}PackageTests.xctest/Contents/MacOS/${FRAMEWORK_NAME}PackageTests -instr-profile .build/debug/codecov/default.profdata > info.lcov
  bash <(curl https://codecov.io/bash) -F travis -F macOS -n $TRAVIS_JOB_NUMBER-$TRAVIS_OS_NAME
else
  llvm-cov export -format="lcov" .build/x86_64-unknown-linux/debug/${FRAMEWORK_NAME}PackageTests.xctest -instr-profile .build/debug/codecov/default.profdata > info.lcov
  bash <(curl https://codecov.io/bash) -F travis -F bionic -n $TRAVIS_JOB_NUMBER-$TRAVIS_OS_NAME
fi

if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  swift package dump-package | jq -e ".products | length > 0"
  pod lib lint --silent  
  swift package generate-xcodeproj
  pod install --silent --project-directory=Example
  xcodebuild -quiet -workspace Example/Example.xcworkspace -scheme "iOS Example"  ONLY_ACTIVE_ARCH=NO  CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO  CODE_SIGNING_ALLOWED=NO &
  xcodebuild -quiet -workspace Example/Example.xcworkspace -scheme "tvOS Example"  ONLY_ACTIVE_ARCH=NO   CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO  CODE_SIGNING_ALLOWED=NO &
  xcodebuild -quiet -workspace Example/Example.xcworkspace -scheme "macOS Example"  ONLY_ACTIVE_ARCH=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO  CODE_SIGNING_ALLOWED=NO &
  wait
fi
