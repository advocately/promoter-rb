module Promoter
  class Metric < Resource
    self.path =  "/metrics/"

    include Operations::All
    include Operations::Retrieve
  end
end
