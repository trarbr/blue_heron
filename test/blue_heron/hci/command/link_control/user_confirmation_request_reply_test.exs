defmodule BlueHeron.HCI.Command.LinkControl.UserConfirmationRequestReplyTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Command.LinkControl.UserConfirmationRequestReply

  test "encodes parameters correctly" do
    serialized =
      %UserConfirmationRequestReply{
        bd_addr: 0x001122334455
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x2C, 0x04, 6, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)

    expected = %UserConfirmationRequestReply{
      bd_addr: bd_addr
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> UserConfirmationRequestReply.deserialize()
  end
end
