defmodule BlueHeron.HCI.Command.LinkControl.AcceptConnectionRequest do
  use BlueHeron.HCI.Command.LinkControl, ocf: 0x0009

  defparameters [:bd_addr, :role]

  defimpl BlueHeron.HCI.Serializable do
    def serialize(%{opcode: opcode, bd_addr: bd_addr, role: role}) do
      <<opcode::binary, 7, bd_addr::little-48, role>>
    end
  end

  @impl BlueHeron.HCI.Command
  def deserialize(<<@opcode::binary, 7, bd_addr::little-48, role>>) do
    new(opcode: @opcode, bd_addr: bd_addr, role: role)
  end

  @impl BlueHeron.HCI.Command
  def deserialize_return_parameters(<<>>) do
    %{}
  end

  @impl true
  def serialize_return_parameters(%{}) do
    <<>>
  end
end
