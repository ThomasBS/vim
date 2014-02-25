Installation
============

-   Clone this repository into your homedir:
    <pre><code>git clone https://github.com/ThomasBS/vim.git ~/.vim</code></pre>

-   Remove your .vimrc file
    <pre><code>rm ~/.vimrc</code></pre>

-   Symlink to the vimrc located in projects .vim folder
    <pre><code>ln -s .vim/vimrc .vimrc</code></pre>

-   Clone vundle into .vim/bundle
    <pre><code>git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle</code></pre>

-   Reload vim

-   Run BundleInstall command from Vim
    <pre><code>:BundleInstall</code></pre>

-   Enjoy!
