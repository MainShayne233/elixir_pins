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
    :os.cmd('echo #{pin} > /sys/class/gpio/export')
    |> IO.inspect
    pin
  end

  def unexport pin do
    :os.cmd('echo #{pin} > /sys/class/gpio/unexport')
    |> IO.inspect
    pin
  end

  def set_direction pin, direction do
    case :os.cmd('echo #{direction} > /sys/class/gpio/gpio#{pin}/direction') do
      [] ->
        pin
      error ->
        IO.inspect error
        set_value pin, direction
    end
    pin
  end

  def set_value pin, value do
    :os.cmd('echo #{value} > /sys/class/gpio/gpio#{pin}/value')
    |> IO.inspect
    pin
  end

  def is_exported? pin do

  end

end
