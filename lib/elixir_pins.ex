defmodule ElixirPins do

  def turn_on pin do
    pin
    |> export
    |> set_direction(:out)
    |> set_value(1)
    {:ok, pin}
  end

  def turn_off pin do
    pin
    |> unexport
    {:ok, pin}
  end

  def export pin do
    case :os.cmd('echo #{pin} > /sys/class/gpio/export') do
      [] ->
        pin
      error ->
        IO.inspect error
        export pin
    end
  end

  def unexport pin do
    case :os.cmd('echo #{pin} > /sys/class/gpio/unexport') do
      [] ->
        pin
      error ->
        IO.inspect error
        unexport pin
    end
  end

  def set_direction pin, direction do
    case :os.cmd('echo #{direction} > /sys/class/gpio/gpio#{pin}/direction') do
      [] ->
        pin
      error ->
        IO.inspect error
        set_direction pin, direction
    end
  end

  def set_value pin, value do
    case :os.cmd('echo #{value} > /sys/class/gpio/gpio#{pin}/value') do
      [] ->
        pin
      error ->
        IO.inspect error
        set_value pin, value
    end
  end

  def is_exported? pin do
    out = :os.cmd 'ls /sys/class/gpio/gpio4'
    out == 'active_low\ndevice\ndirection\nedge\npower\nsubsystem\nuevent\nvalue\n'
  end
# Hey it's Trisha!
# end
# def is_drunk? pin do
#   out = 'idk'
#   inspect error
#   Love u so much have a good day
# end
# end

end
