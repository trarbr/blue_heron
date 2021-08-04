defmodule BlueHeron.HCI.Event.ConnectionRequest do
  # TODO: # test with: HCI_Connection_Request: <<0x4, 0x4, 0xA, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90, 0xC, 0x1, 0x38, 0x1>>
  use BlueHeron.HCI.Event, code: 0x04

  @moduledoc """
  The HCI_Connection_Request event is used to indicate that a new incoming
  connection is trying to be established.

  The connection may either be accepted or rejected. When the Host receives this
  event and the link type parameter is ACL, it should respond with either an
  HCI_Accept_Connection_Request or HCI_Reject_Connection_Request command before
  the timer Connection_Accept_Timeout expires.

  Reference: Version 5.2, Vol 4, Part E, 7.7.4
  """

  defparameters [
    :bd_addr,
    :class_of_device,
    :link_type
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(cr) do
      <<cr.code, 10, cr.bd_addr::little-48, cr.class_of_device::little-24, cr.link_type>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(<<@code, _size, bd_addr::little-48, class_of_device::little-24, link_type>>) do
    %__MODULE__{
      bd_addr: bd_addr,
      class_of_device: class_of_device,
      link_type: link_type
    }
  end
end
