FROM ruby:3.3.5

# Install necessary packages, Node.js, and Neovim
RUN apt-get update && apt-get install -y vim curl zsh git neovim \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

# Set Neovim as the default editor
RUN update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 \
    && update-alternatives --set editor /usr/bin/nvim

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# Install Solargraph for Ruby
RUN gem install solargraph

# Install Vim-Plug for Neovim
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set up Neovim configuration for Ruby development
RUN mkdir -p ~/.config/nvim

RUN echo 'call plug#begin("~/.local/share/nvim/plugged")\n' \
         'Plug "neoclide/coc.nvim", {"branch": "release"}\n' \
         'Plug "preservim/nerdtree"\n' \
         'Plug "vim-ruby/vim-ruby"\n' \
         'Plug "tpope/vim-rails"\n' \
         'Plug "tpope/vim-bundler"\n' \
         'call plug#end()\n' \
         'autocmd BufWritePre *.rb :CocCommand solargraph.documentFormat\n' \
         'let g:coc_global_extensions = ["coc-solargraph"]\n' \
    > ~/.config/nvim/init.vim

# Install Neovim plugins
RUN nvim +PlugInstall +qall

# Set Zsh as the default shell
SHELL ["/bin/zsh", "-c"]
