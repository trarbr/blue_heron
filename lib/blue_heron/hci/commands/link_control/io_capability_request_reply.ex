defmodule BlueHeron.HCI.Command.LinkControl.IOCapabilityRequestReply do
  use BlueHeron.HCI.Command.LinkControl, ocf: 0x002B

  defparameters [:bd_addr, :io_capability, :oob_data_present, :authentication_requirements]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{
          opcode: opcode,
          bd_addr: bd_addr,
          io_capability: io_capability,
          oob_data_present: oob_data_present,
          authentication_requirements: authentication_requirements
        }) do
      <<opcode::binary, 9, bd_addr::little-48, io_capability, oob_data_present,
        authentication_requirements>>
    end
  end

  @impl BlueHeron.HCI.Command
  def deserialize(
        <<@opcode::binary, 9, bd_addr::little-48, io_capability, oob_data_present,
          authentication_requirements>>
      ) do
    new(
      opcode: @opcode,
      bd_addr: bd_addr,
      io_capability: io_capability,
      oob_data_present: oob_data_present,
      authentication_requirements: authentication_requirements
    )
  end

  @impl BlueHeron.HCI.Command
  def deserialize_return_parameters(<<status, bd_addr::little-48>>) do
    %{status: status, bd_addr: bd_addr}
  end

  @impl BlueHeron.HCI.Command
  def serialize_return_parameters(%{status: status, bd_addr: bd_addr}) do
    <<BlueHeron.ErrorCode.to_code!(status), bd_addr::little-48>>
  end
end
