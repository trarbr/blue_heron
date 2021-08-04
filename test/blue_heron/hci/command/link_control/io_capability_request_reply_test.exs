defmodule BlueHeron.HCI.Command.LinkControl.IOCapabilityRequestReplyTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Command.LinkControl.IOCapabilityRequestReply

  test "encodes parameters correctly" do
    serialized =
      %IOCapabilityRequestReply{
        bd_addr: 0x001122334455,
        io_capability: 0x01,
        oob_data_present: 0x00,
        authentication_requirements: 0x02
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x2B, 0x04, 9, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00, 0x01, 0x00, 0x02>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    io_capability = Enum.random(0x00..0x03)
    oob_data_present = Enum.random(0x00..0x03)
    authentication_requirements = Enum.random(0x00..0x05)

    expected = %IOCapabilityRequestReply{
      bd_addr: bd_addr,
      io_capability: io_capability,
      oob_data_present: oob_data_present,
      authentication_requirements: authentication_requirements
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> IOCapabilityRequestReply.deserialize()
  end
end
