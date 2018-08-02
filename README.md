# Android SDK docker image

Minimal Ubuntu based Docker image with the Android SDK for building Android apps in a CI tool like GitLab CI. Make sure your CI environment's caching works as expected, this greatly improves the build time, especially if you use multiple build jobs.

A `.gitlab-ci.yml` with caching of your project's dependencies would look something like this:

```
image: vadyochik/android-sdk

stages:
- build

before_script:
- export GRADLE_USER_HOME=$(pwd)/.gradle
- chmod +x ./gradlew

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - .gradle/

build:
  stage: build
  script:
  - ./gradlew assembleDebug
  artifacts:
    paths:
    - app/build/outputs/apk/app-debug.apk
```

Many thanks to the following nice guys:

- https://github.com/jangrewe/gitlab-ci-android
- https://github.com/bitrise-docker/android
- https://github.com/jerbob92/gitlab-ci-android
- https://github.com/jangrewe/gitlab-ci-android
- https://gitlab.com/showcheap/android-ci

