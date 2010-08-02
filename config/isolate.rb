gem "rails",         "= 2.3.8"
gem "uuid",          "= 2.3.1"
gem "will_paginate", "= 2.3.14"
gem "haml",          "= 3.0.6"
gem "paperclip",     "= 2.3.1.1"

env :development, :test do
  gem "modelizer"
  gem "sqlite3-ruby"
end

env :production do
  gem "mysql"
end
