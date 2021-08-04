defmodule BlueHeron.HCI.Event.SimplePairingComplete do
  use BlueHeron.HCI.Event, code: 0x36

  # TODO: test with <<0x4, 0x36, 0x7, 0x5, 0x52, 0x2B, 0xC7, 0x4A, 0x9C, 0x90>>

  @moduledoc """
  The HCI_Simple_Pairing_Complete event is used to indicate that the simple
  pairing process has completed. A Host that is displaying a numeric value can
  use this event to change its UI.

  When the LMP simple pairing sequences fail for any reason, the
  HCI_Simple_Pairing_Complete event shall be sent to the Host. When
  HCI_Simple_Pairing_Complete event is sent in response to the IO capability
  exchange failing, the Status parameter shall be set to the error code received
  from the remote device. Otherwise, the Status shall be set to the error code
  Authentication Failure (0x05).

  Reference: Version 5.2, Vol 4, Part E, 7.7.45
  """

  defparameters [
    :status,
    :bd_addr
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{code: code, status: status, bd_addr: bd_addr}) do
      <<code, 7, status, bd_addr::little-48>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(<<@code, _size, status, bd_addr::little-48>>) do
    %__MODULE__{
      status: status,
      bd_addr: bd_addr
    }
  end
end
