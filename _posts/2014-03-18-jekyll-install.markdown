---
layout: post
title:  "Jekyll Install"
date:   2014-03-18 11:43:10
categories: jekyll update
---

If [github.com][github] wasn't awesome enough, they'll host your jekyll blogs for free.

First, [create github repo][github-new] called [msmithgu.github.io][msmithgu]

Then, assuming I've got ruby 1.9+..

{% highlight bash %}
  gem install jekyll
  jekyll new ~/git/msmithgu.github.io
  cd ~/git/msmithgu.github.io
  git init
  touch README
  git add .
  git commit -m "installed jekyll"
  git remote add origin git@github.com:msmithgu/msmithgu.github.io.git
  git push origin master
{% endhighlight %}

See it live at http://msmithgu.github.io/

Tweak, commit and push to customize..

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll.

[msmithgu]: https://msmithgu.github.io
[github]: https://github.com
[github-new]: https://github.com/new
[jekyll]:    http://jekyllrb.com
