defmodule BlueHeron.HCI.Event.ConnectionRequestTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.ConnectionRequest

  test "encodes parameters correctly" do
    serialized =
      %ConnectionRequest{
        bd_addr: 0x909C4AC72B52,
        class_of_device: 0x38010C,
        link_type: 0x01
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x04, 0x0A, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90, 0x0C, 0x01, 0x38, 0x01>> ==
             serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    class_of_device = Enum.random(0x00..0xFFFFFF)
    link_type = Enum.random(0x00..0x02)

    expected = %ConnectionRequest{
      bd_addr: bd_addr,
      class_of_device: class_of_device,
      link_type: link_type
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> ConnectionRequest.deserialize()
  end
end
