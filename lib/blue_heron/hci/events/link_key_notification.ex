defmodule BlueHeron.HCI.Event.LinkKeyNotification do
  use BlueHeron.HCI.Event, code: 0x18

  @moduledoc """
  The HCI_Link_Key_Notification event is used to indicate to the Host that a new
  Link Key has been created for the connection with the device specified in
  BD_ADDR.

  The Host can save this new Link Key in its own storage for future use. Also,
  the Host can decide to store the Link Key in the BR/EDR Controller’s Link Key
  Storage by using the HCI_Write_Stored_Link_Key command. The Key_Type event
  parameter informs the Host about which key type (combination key, debug
  combination key, unauthenticated combination key, authenticated combination
  key or changed combination key) was used during pairing. If the key type is
  not supported or is reserved for future use, the Host may discard the key or
  disconnect the link.

  Reference: Version 5.2, Vol 4, Part E, 7.7.24
  """

  defparameters [
    :bd_addr,
    :link_key,
    :key_type
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{code: code, bd_addr: bd_addr, link_key: link_key, key_type: key_type}) do
      <<code, 23, bd_addr::little-48, link_key::little-128, key_type>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(<<@code, _size, bd_addr::little-48, link_key::little-128, key_type>>) do
    %__MODULE__{
      bd_addr: bd_addr,
      link_key: link_key,
      key_type: key_type
    }
  end
end
