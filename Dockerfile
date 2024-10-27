FROM ruby:3.3.5

# Install vim, curl, git
RUN apt-get update && apt-get install -y vim curl git nodejs npm

# Install SpaceVim
RUN curl -sLf https://spacevim.org/install.sh | bash

RUN gem install solargraph

COPY .SpaceVim.d /root/.SpaceVim.d

# Then install coc-solargraph extension for coc to support solargraph with the next command:
RUN vim -c "PlugInstall" -c "qa"

# Set default command
CMD ["tail", "-f", "/dev/null"]