defmodule BlueHeron.HCI.Event.LinkKeyNotificationTest do
  use ExUnit.Case

  alias BlueHeron.HCI.Event.LinkKeyNotification

  test "encodes parameters correctly" do
    serialized =
      %LinkKeyNotification{
        bd_addr: 0x909C4AC72B52,
        link_key: 0x7CABBFA6967EE49A959F95CB890AE1B6,
        key_type: 0x04
      }
      |> BlueHeron.HCI.Serializable.serialize()

    assert <<0x18, 0x17, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90, 0xB6, 0xE1, 0x0A, 0x89, 0xCB, 0x95,
             0x9F, 0x95, 0x9A, 0xE4, 0x7E, 0x96, 0xA6, 0xBF, 0xAB, 0x7C, 0x04>> == serialized
  end

  test "serde is symmetric" do
    bd_addr = Enum.random(0x00..0xFFFFFFFFFFFF)
    link_key = Enum.random(0x00..0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
    key_type = Enum.random(0x00..0x08)

    expected = %LinkKeyNotification{
      bd_addr: bd_addr,
      link_key: link_key,
      key_type: key_type
    }

    assert expected ==
             expected
             |> BlueHeron.HCI.Serializable.serialize()
             |> LinkKeyNotification.deserialize()
  end
end
