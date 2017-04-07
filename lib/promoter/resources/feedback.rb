module Promoter
  class Feedback < Resource
    self.path = "/feedback/"

    include Operations::All
    include Operations::Retrieve
  end
end
