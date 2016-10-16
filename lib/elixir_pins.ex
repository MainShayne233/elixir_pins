defmodule ElixirPins do

  def turn_on pin do
    pin
    |> export
    |> export
    |> set_direction(:out)
    |> set_value(1)
    {:ok, pin}
  end

  def turn_off pin do
    pin
    |> set_value('')
    |> set_direction('')
    |> unexport
    {:ok, pin}
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
    :os.cmd 'echo #{direction} > /sys/class/gpio/gpio#{pin}/direction'
    pin
  end

  def set_value pin, value do
    :os.cmd 'echo #{value} > /sys/class/gpio/gpio#{pin}/value'
    pin
  end

end
