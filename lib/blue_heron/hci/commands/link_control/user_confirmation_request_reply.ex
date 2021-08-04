defmodule BlueHeron.HCI.Command.LinkControl.UserConfirmationRequestReply do
  use BlueHeron.HCI.Command.LinkControl, ocf: 0x002C

  defparameters [:bd_addr]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{opcode: opcode, bd_addr: bd_addr}) do
      <<opcode::binary, 6, bd_addr::little-48>>
    end
  end

  @impl BlueHeron.HCI.Command
  def deserialize(<<@opcode::binary, _param_length, bd_addr::little-48>>) do
    new(opcode: @opcode, bd_addr: bd_addr)
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
