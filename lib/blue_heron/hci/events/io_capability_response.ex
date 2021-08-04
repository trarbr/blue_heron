defmodule BlueHeron.HCI.Event.IOCapabilityResponse do
  use BlueHeron.HCI.Event, code: 0x32

  @moduledoc """
  The HCI_IO_Capability_Response event is used to indicate to the Host that IO
  capabilities from a remote device specified by BD_ADDR have been received
  during a simple pairing process. This event will only be generated if simple
  pairing has been enabled with the HCI_Write_Simple_Pairing_Mode command.

  Reference: Version 5.2, Vol 4, Part E, 7.7.41
  """

  defparameters [
    :bd_addr,
    :io_capability,
    :oob_data_present,
    :authentication_requirements
  ]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(iocr) do
      <<iocr.code, 9, iocr.bd_addr::little-48, iocr.io_capability, iocr.oob_data_present,
        iocr.authentication_requirements>>
    end
  end

  @impl BlueHeron.HCI.Event
  def deserialize(
        <<@code, _size, bd_addr::little-48, io_capability, oob_data_present,
          authentication_requirements>>
      ) do
    %__MODULE__{
      bd_addr: bd_addr,
      io_capability: io_capability,
      oob_data_present: oob_data_present,
      authentication_requirements: authentication_requirements
    }
  end
end
