defmodule Cache do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [Map.new(), 0])
    Process.register(pid, :cache)
    pid
  end

  def put(url, page) do
    send(:cache, {:put, url, page})
  end

  def get(url) do
    ref = make_ref()
    send(:cache, {:get, self(), ref, url})

    receive do
      {:ok, ^ref, page} -> page
    after
      1000 -> nil
    end
  end

  def size do
    ref = make_ref()
    send(:cache, {:size, self(), ref})

    receive do
      {:ok, ^ref, s} -> s
    after
      1000 -> nil
    end
  end

  def terminate do
    send(:cache, {:terminate})
  end

  def loop(pages, size) do
    receive do
      {:put, url, page} ->
        new_pages = Map.put(pages, url, page)
        new_size = size + byte_size(page)
        loop(new_pages, new_size)

      {:get, sender, ref, url} ->
        send(sender, {:ok, ref, pages[url]})
        loop(pages, size)

      {:size, sender, ref} ->
        send(sender, {:ok, ref, size})
        loop(pages, size)

      {:terminate} ->
        nil
    end
  end
end

defmodule CacheSupervisor do
  def start do
    spawn(__MODULE__, :loop_system, [])
  end

  def loop do
    pid = Cache.start_link()

    receive do
      {:EXIT, ^pid, :normal} ->
        IO.puts("Cache exited normally.")
        :ok

      {:EXIT, ^pid, reason} ->
        IO.puts("Cache failed with reason #{inspect(reason)} - restarting it.")
        loop()
    end

    loop()
  end

  def loop_system do
    Process.flag(:trap_exit, true)
    loop()
  end
end

# CacheSupervisor.start()
# Cache.put("google.com", "Welcome to Google...")
# Cache.get("google.com")
# Cache.size()
# Cache.put("amazon.com", nil)
# boom! (ArgumentError) argument error :erlang.byte_size(nil)
# Cache.size()
# Cache.put("twitter.com", "cat photos")
# Cache.get("twitter.com")
# Cache.size()
