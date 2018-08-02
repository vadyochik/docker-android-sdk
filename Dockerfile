#
# GitLab CI: Android v0.1
#
# Based on:
#
# https://github.com/bitrise-docker/android
# https://github.com/jerbob92/gitlab-ci-android
# https://github.com/jangrewe/gitlab-ci-android
# https://gitlab.com/showcheap/android-ci
#

FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends lib32ncurses5 lib32stdc++6 openjdk-8-jdk wget unzip

ENV ANDROID_HOME "/sdk"
ENV PATH "${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools"

# Install Android SDK tools into $ANDROID_HOME
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

# Accept licenses before installing components, no need to echo y for each component
# License is valid for all the standard components in versions installed from this file
# Non-standard components: MIPS system images, preview versions, GDK (Google Glass) and Android Google TV require separate licenses, not accepted there
RUN yes | sdkmanager --licenses

# Platform tools
RUN sdkmanager "emulator" "tools" "platform-tools"

