defmodule BlueHeron.HCI.Event.UserConfirmationRequest do
  use BlueHeron.HCI.Event, code: 0x33

  @moduledoc """
  The HCI_User_Confirmation_Request event is used to indicate that user
  confirmation of a numeric value is required.

  The Host shall reply with either the HCI_User_Confirmation_Request_Reply or
  the HCI_User_Confirmation_Request_Negative_Reply command. If the Host has
  output capability (DisplayYesNo or KeyboardOnly), it shall display the
  Numeric_Value until the HCI_Simple_Pairing_Complete event is received. It
  shall reply based on the yes/no response from the user. If the Host has no
  input and no output it shall reply with the
  HCI_User_Confirmation_Request_Reply command. When the Controller generates an
  HCI_User_Confirmation_Request event, in order for the local Link Manager to
  respond to the request from the remote Link Manager, the local Host shall
  respond with either an HCI_User_Confirmation_Request_Reply or an
  HCI_User_Confirmation_Request_Negative_Reply command before the remote Link
  Manager detects LMP response timeout.

  Reference: Version 5.2, Vol 4, Part E, 7.7.42
  """

  # TODO: numeric value can be 0x00000000 to 0x000F423F
  defparameters [
    :bd_addr,
    :numeric_value
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{code: code, bd_addr: bd_addr, numeric_value: numeric_value}) do
      <<code, 10, bd_addr::little-48, numeric_value::little-32>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(<<@code, _size, bd_addr::little-48, numeric_value::little-32>>) do
    %__MODULE__{
      bd_addr: bd_addr,
      numeric_value: numeric_value
    }
  end
end
