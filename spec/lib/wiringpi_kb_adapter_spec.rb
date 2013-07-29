require 'spec_helper'

module WiringPi
  describe GPIO do
    let(:input_pins)  { {goal_a: 0, goal_b: 3, start: 4} }
    let(:output_pins) { {led: 7} }
    let(:subject) { GPIO.new(:input_pins => input_pins, :output_pins => output_pins) }

    # attr_reader
    %w[input_pins output_pins mode_pins].each do |method|
      it { should respond_to method }
    end

    %w[mode write readAll].each do |method|
      it { should respond_to method}
    end
  end
end