module Metrc
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{ |f| require f }

    include Metrc::Client::All
    include Metrc::Client::Parser
  end
end