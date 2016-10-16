defmodule ElixirPins do

  def turn_on pin do
    Integer.to_string(pin)
    |> export
    |> set_out
    |> set_on
  end

  def export pin do
    {:ok, file} = File.open "/sys/class/gpio/export", [:write]
    IO.binwrite file, pin
    pin
  end

  def set_out pin do
    {:ok, file} = File.open "/sys/class/gpio/gpio#{pin}/direction", [:write]
    IO.binwrite file, "out"
    pin
  end

  def set_on pin do
    {:ok, file} = File.open "/sys/class/gpio/gpio#{pin}/value", [:write]
    IO.binwrite file, "1"
    pin
  end
end
