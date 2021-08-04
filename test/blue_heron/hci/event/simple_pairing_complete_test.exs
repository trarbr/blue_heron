defmodule BlueHeron.HCI.Event.SimplePairingCompleteTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.SimplePairingComplete

  test "encodes parameters correctly" do
    serialized =
      %SimplePairingComplete{
        status: 0x00,
        bd_addr: 0x909C4AC72B52
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x36, 0x7, 0x0, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90>> == serialized
  end

  test "serde is symmetric" do
    status = Enum.random(0x00..0x10)
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)

    expected = %SimplePairingComplete{
      status: status,
      bd_addr: bd_addr
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> SimplePairingComplete.deserialize()
  end
end
