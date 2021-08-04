defmodule BlueHeron.HCI.Command.LinkControl.AcceptConnectionRequestTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Command.LinkControl.AcceptConnectionRequest

  test "encodes parameters correctly" do
    serialized =
      %AcceptConnectionRequest{bd_addr: 0x001122334455, role: 0x01}
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x09, 0x04, 7, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00, 0x01>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    role = Enum.random(0x00..0x01)

    expected = %AcceptConnectionRequest{bd_addr: bd_addr, role: role}

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> AcceptConnectionRequest.deserialize()
  end
end
