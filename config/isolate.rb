gem "rails",         "= 2.3.11"
gem "uuid",          "= 2.3.1"
gem "will_paginate", "= 2.3.14"
gem "haml",          "= 3.0.6"
gem "paperclip",     "= 2.3.1.1"
gem "rvideo"
gem "rdiscount"
gem "disqus"
gem "twitter_oauth"
gem "rest-client"
gem "zencoder"

env :development, :test do
  gem "modelizer"
  gem "sqlite3-ruby"
  gem "ruby-mysql", "=2.9.3", :lib => 'mysql'
end

env :production do
  gem "ruby-mysql", "=2.9.3", :lib => 'mysql'
end
