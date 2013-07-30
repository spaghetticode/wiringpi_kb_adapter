require 'spec_helper'

module WiringPi
  describe GPIO do
    let(:input_pins)  { {goal_a: 0, goal_b: 3, start: 4} }
    let(:output_pins) { {led: 7} }
    let(:subject) { GPIO.new(:input_pins => input_pins, :output_pins => output_pins) }

    # attr_readers
    %w[input_pins output_pins mode_pins].each do |method|
      it { should respond_to method }
    end

    %w[mode write readAll].each do |method|
      it { should respond_to method}
    end

    describe '#readAll' do
      context 'when no key is pressed' do
        before { subject.stub :getch => nil }

        it { subject.readAll.should be_a Hash }

        it 'returns a hash with default values set to 1' do
          subject.readAll[:something].should == 1
        end
      end

      context 'when no pin associated character is pressed' do
        before { subject.stub :getch => 'A' }

        it 'adds no pair to the hash' do
          subject.readAll.size.should be_zero
        end
      end

      context 'when a pin associated character is pressed' do
        before { subject.stub :getch => '4' }

        it 'adds the expected pair to the hash' do
          subject.readAll.size.should_not be_zero
        end

        it 'sets the pin value in the hash to zero' do
          h = subject.readAll
          puts h.inspect
          h[4].should be_zero
        end
      end
    end
  end
end