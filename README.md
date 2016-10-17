# ElixirPins
Elixir API for Raspberry PI GPIO pins

## Install
Add
```elixir
{:elixir_pins, "0.0.1"}
```
to your dependency list in your mix.exs file.

Example:
```elixir
defp deps do
  [
    {:elixir_pins, "0.0.1"}
  ]
end
```

## Running locally on Pi
```elixir
ElixirPins.turn_on 4   #-> turns GPIO4 (pin #7) on
ElixirPins.turn_off 4  #-> turns GPIO4 (pin #7) off
```

## Running on remote computer
``` elixir
client = [
  ip:       '192.168.1.123', # ip address of raspberry pi
  user:     'pi',            # username of user on raspberry pi
  password: 'securepassword' # password for specified user
]
ElixirPins.turn_on 4, client   #-> turns GPIO4 (pin #7) on
ElixirPins.turn_off 4, client  #-> turns GPIO4 (pin #7) off
```
