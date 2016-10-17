defmodule ElixirPins do

  def turn_on pin do
    pin
    |> export
    |> set_direction(:out)
    |> set_value(1)
    {:ok, pin}
  end

  def turn_on pin, client do
    {:ok, conn} = SSHEx.connect client
    pin
    |> export(conn)
    |> set_direction(conn, :out)
    |> set_value(conn, 1)
    {:ok, pin}
  end

  def turn_off pin do
    pin
    |> unexport
    {:ok, pin}
  end

  def turn_off pin, client do
    {:ok, conn} = SSHEx.connect client
    pin
    |> unexport(conn)
    {:ok, pin}
  end

  def export pin do
    unless is_exported?(pin) do
      :os.cmd 'echo #{pin} > /sys/class/gpio/export'
    end
    pin
  end

  def export pin, conn do
    unless is_exported?(pin, conn) do
      SSHEx.cmd! conn, 'echo #{pin} > /sys/class/gpio/export'
    end
    pin
  end

  def unexport pin do
    if is_exported?(pin) do
      :os.cmd 'echo #{pin} > /sys/class/gpio/unexport'
    end
    pin
  end

  def unexport pin, conn do
    if is_exported?(pin, conn) do
      SSHEx.cmd! conn, 'echo #{pin} > /sys/class/gpio/unexport'
    end
    pin
  end

  def set_direction pin, direction do
    case :os.cmd('echo #{direction} > /sys/class/gpio/gpio#{pin}/direction') do
      [] ->
        pin
      _ ->
        set_direction pin, direction
    end
  end

  def set_direction pin, conn, direction do
    case SSHEx.cmd! conn, 'echo #{direction} > /sys/class/gpio/gpio#{pin}/direction' do
      "" ->
        pin
      _ ->
        set_direction pin, conn, direction
    end
  end

  def set_value pin, value do
    case :os.cmd('echo #{value} > /sys/class/gpio/gpio#{pin}/value') do
      [] ->
        pin
      _ ->
        set_value pin, value
    end
  end

  def set_value pin, conn, value do
    case SSHEx.cmd! conn, 'echo #{value} > /sys/class/gpio/gpio#{pin}/value' do
      "" ->
        pin
      _ ->
        set_value pin, conn, value
    end
  end

  def is_exported? pin do
    out = :os.cmd 'ls /sys/class/gpio/gpio#{pin}'
    out == 'active_low\ndevice\ndirection\nedge\npower\nsubsystem\nuevent\nvalue\n'
  end

  def is_exported? pin, conn do
    out = SSHEx.cmd! conn, 'ls /sys/class/gpio/gpio#{pin}'
    out == "active_low\ndevice\ndirection\nedge\npower\nsubsystem\nuevent\nvalue\n"
  end

end
