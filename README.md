http://msmithgu.github.io/

To setup:

    gem install jekyll
    jekyll new ~/git/msmithgu.github.io
    cd ~/git/msmithgu.github.io
    git init
    touch README
    git add .
    git commit -m "installed jekyll"
    git remote add origin git@github.com:msmithgu/msmithgu.github.io.git
    git push origin master

To serve:

    jekyll serve

To auto-build:

    jekyll build -w
