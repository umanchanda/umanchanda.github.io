FROM gitpod/workspace-full

RUN sudo apt-get update \
 && sudo apt-get install -y \
 && sudo apt-get install ruby-full build-essential zlib1g-dev \
 && gem install jekyll bundler