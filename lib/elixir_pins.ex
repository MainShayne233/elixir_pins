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


end
