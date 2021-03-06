INPUT         = $stdin
OUTPUT        = $stdout
WPI_MODE_PINS = Object.new

require 'curses'

module WiringPi
  def puts(message)
    Curses.addstr message
  end

  class Serial
    def initialize(*args)
      Curses.timeout = 0
      Curses.noecho # do not show typed keys
      Curses.init_screen
      Curses.stdscr.keypad(true) # enable keypad
      Curses.setpos(0, 0)
      @serial_not_read = true
      @serial_count = 0
    end

    def serialDataAvail
      if @finished and !@serial_not_read
        @finished = false
        @serial_count = 0
        @serial_not_read = true
      end
      @serial_not_read ? 1 : 0
    end

    def serialGetchar
      char = (48..57).to_a.sample
      if @serial_count > 4
        @serial_not_read = false
        @finished = true
      end
      @serial_count += 1
      char
    end
  end

  class GPIO
    attr_reader :mode_pins, :input_pins, :output_pins

    def initialize(opts={})
      @input_pins  = opts[:input_pins] or Table::INPUT_PINS
      @output_pins = opts[:output_pins] or Table::OUTPUT_PINS
    end

    def mode(pin_number, io)
      # only once
      # set the mode operation of the pin, if input or output
    end

    def readAll
      # the returned hash has 1 as value for all its keys by default
      hash = Hash.new {|h, k| h[k] = 1}
      char = getch
      if char =~ /\d/
        value = char.to_i
        hash[value] = 0 if key = input_pins.key(value)
      end
      hash
    end

    def write(pin_number, value)
      # puts "pin #{pin_number} is now #{value}"
    end

    private

    def getch
      Curses.getch
    end
  end
end
