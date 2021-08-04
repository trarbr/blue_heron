defmodule BlueHeron.HCI.Event.IOCapabilityRequestTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.IOCapabilityRequest

  test "encodes parameters correctly" do
    serialized =
      %IOCapabilityRequest{
        bd_addr: 0x909C4AC72B52
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x31, 0x6, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)

    expected = %IOCapabilityRequest{
      bd_addr: bd_addr
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> IOCapabilityRequest.deserialize()
  end
end
