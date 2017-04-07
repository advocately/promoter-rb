module Promoter
  class Contact < Resource
    self.path =  "/contacts/"

    include Operations::All
    include Operations::Retrieve
  end
end
