defmodule Cache do
  use GenServer

  def init(state), do: {:ok, state}

  def handle_cast({:put, url, page}, {pages, size}) do
    new_pages = Map.put(pages, url, page)
    new_size = size + byte_size(page)
    {:noreply, {new_pages, new_size}}
  end

  def handle_call({:get, url}, _from, {pages, size}) do
    {:reply, pages[url], {pages, size}}
  end

  def handle_call({:size}, _from, {pages, size}) do
    {:reply, size, {pages, size}}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, {Map.new(), 0}, name: __MODULE__)
  end

  def put(url, page), do: GenServer.cast(__MODULE__, {:put, url, page})
  def get(url), do: GenServer.call(__MODULE__, {:get, url})
  def size, do: GenServer.call(__MODULE__, {:size})
end

defmodule Cache.Application do
  use Application

  def start(_type, _args) do
    children = [
      Cache
    ]

    opts = [strategy: :one_for_one, name: Cache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Cache.Application.start(nil, nil)
# Cache.put("google.com", "Welcome to Google...")
# Cache.get("google.com")
# Cache.size()
# Cache.put("amazon.com", nil)
# boom! (ArgumentError) argument error :erlang.byte_size(nil)
# Cache.size()
# Cache.put("twitter.com", "cat photos")
# Cache.get("twitter.com")
# Cache.size()
