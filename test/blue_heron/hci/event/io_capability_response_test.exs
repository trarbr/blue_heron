defmodule BlueHeron.HCI.Event.IOCapabilityResponseTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.IOCapabilityResponse

  test "encodes parameters correctly" do
    serialized =
      %IOCapabilityResponse{
        bd_addr: 0x909C4AC72B52,
        io_capability: 0x01,
        oob_data_present: 0x00,
        authentication_requirements: 0x02
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x32, 0x9, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90, 0x1, 0x0, 0x2>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    io_capability = Enum.random(0x00..0x03)
    oob_data_present = Enum.random(0x00..0x03)
    authentication_requirements = Enum.random(0x00..0x05)

    expected = %IOCapabilityResponse{
      bd_addr: bd_addr,
      io_capability: io_capability,
      oob_data_present: oob_data_present,
      authentication_requirements: authentication_requirements
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> IOCapabilityResponse.deserialize()
  end
end
