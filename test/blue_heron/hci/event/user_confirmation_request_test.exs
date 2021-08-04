defmodule BlueHeron.HCI.Event.UserConfirmationRequestTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.UserConfirmationRequest

  test "encodes parameters correctly" do
    serialized =
      %UserConfirmationRequest{
        bd_addr: 0x909C4AC72B52,
        numeric_value: 136_822
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x33, 0xA, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90, 0x76, 0x16, 0x2, 0x0>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    numeric_value = Enum.random(0..999_999)

    expected = %UserConfirmationRequest{
      bd_addr: bd_addr,
      numeric_value: numeric_value
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> UserConfirmationRequest.deserialize()
  end
end
