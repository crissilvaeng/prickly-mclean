defmodule Talker do
  def loop do
    receive do
      {:greet, name} -> IO.puts("Hello, #{name}!")
      {:praise, name} -> IO.puts("#{name}, you're amazing!")
      {:celebrate, name, age} -> IO.puts("Here's to another #{age} years, #{name}!")
      {:shutdown} -> exit(:normal)
    end
    loop
  end
end

Process.flag(:trap_exit, true)
pid = spawn_link(&Talker.loop/0)

send(pid, {:greet, "Cristina"})
send(pid, {:praise, "Lenilson"})
send(pid, {:celebrate, "Tobias", 8})
send(pid, {:shutdown})

receive do
  {:EXIT, ^pid, reason} -> IO.puts("Talker has exited (#{reason})")
end

:timer.sleep(1000)
