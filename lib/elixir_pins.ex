defmodule ElixirPins do

  def turn_on pin do
    Integer.to_string(pin)
    |> export
    |> set_direction(:out)
    |> set_value(1)
  end

  def export pin do
    :os.cmd 'echo #{pin} > /sys/class/gpio/export'
    pin
  end

  def unexport pin do
    :os.cmd 'echo #{pin} > /sys/class/gpio/unexport'
    pin
  end

  def set_direction pin, direction do
    :os.cmd 'echo #{Atom.to_string(direction)} > /sys/class/gpio/gpio#{pin}/direction'
    pin
  end

  def set_value pin, value do
    :os.cmd 'echo #{Integer.to_string(value)} > /sys/class/gpio/gpio#{pin}/value'
    pin
  end

end
