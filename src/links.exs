defmodule LinkLab do
  def loop_system do
    Process.flag(:trap_exit, true)
    loop()
  end

  def loop do
    receive do
      {:exit_because, reason} ->
        exit(reason)

      {:link_to, pid} ->
        Process.link(pid)

      {:EXIT, pid, reason} ->
        IO.puts("#{inspect(pid)} exited because #{reason}")
    end

    loop()
  end
end
