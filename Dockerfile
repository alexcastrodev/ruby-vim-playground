FROM ruby:3.3.5

# Install necessary packages, Node.js, and Oh My Zsh
RUN apt-get update && apt-get install -y vim curl zsh git \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# Install SpaceVim
RUN curl -sLf https://spacevim.org/install.sh | bash

# Install Solargraph for Ruby
RUN gem install solargraph

# Install coc-solargraph and other coc extensions for autocompletion
RUN vim +'CocInstall -sync coc-solargraph' +qall