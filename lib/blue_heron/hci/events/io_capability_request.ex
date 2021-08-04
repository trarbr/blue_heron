defmodule BlueHeron.HCI.Event.IOCapabilityRequest do
  use BlueHeron.HCI.Event, code: 0x31

  @moduledoc """
  The HCI_IO_Capability_Request event is used to indicate that the IO
  capabilities of the Host are required for a simple pairing process. The Host
  shall respond with an HCI_IO_Capability_Request_Reply command or
  HCI_IO_Capability_Request_Negative_Reply command. This event shall only be
  generated if simple pairing has been enabled with the
  HCI_Write_Simple_Pairing_Mode command.

  Reference: Version 5.2, Vol 4, Part E, 7.7.40
  """

  defparameters [
    :bd_addr
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{code: code, bd_addr: bd_addr}) do
      <<code, 6, bd_addr::little-48>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(<<@code, _size, bd_addr::little-48>>) do
    %__MODULE__{
      bd_addr: bd_addr
    }
  end
end
