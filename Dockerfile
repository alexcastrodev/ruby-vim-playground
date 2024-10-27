FROM ruby:3.3.5

# Install vim, curl, git
RUN apt-get update && apt-get install -y vim curl git nodejs npm tmux

# Install SpaceVim
RUN curl -sLf https://spacevim.org/install.sh | bash

RUN gem install solargraph ruby-lint rubocop

COPY .SpaceVim.d /root/.SpaceVim.d

# Set default command
CMD ["tail", "-f", "/dev/null"]