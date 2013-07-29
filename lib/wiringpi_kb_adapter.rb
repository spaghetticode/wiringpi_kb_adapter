require "wiringpi_kb_adapter/version"

module WiringpiKbAdapter
  begin
    require 'wiringpi'
  rescue LoadError
    require File.expand_path('../wiring_pi', __FILE__)
  end
end
