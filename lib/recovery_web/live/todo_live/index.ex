defmodule RecoveryWeb.TodoLive.Index do
  use RecoveryWeb, :live_view

  alias Recovery.Todos
  alias Recovery.Todos.Todo

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:editing, [])
      |> assign(:todos, list_todos())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket =
      case params["editing"] do
        nil ->
          assign(socket, :editing, [])

        list ->
          ids =
            list
            |> Enum.map(&String.to_integer/1)
            |> Enum.uniq

          assign(socket, :editing, ids)
      end

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, Todos.get_todo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, %Todo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:todo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    {:ok, _} = Todos.delete_todo(todo)

    {:noreply, assign(socket, :todos, list_todos())}
  end

  def handle_event("edit", %{"id" => id}, socket) do
    editing = [id | socket.assigns.editing]
    {:noreply, push_patch(socket, to: Routes.todo_index_path(socket, :index, editing: editing))}
  end

  @impl true
  def handle_info({:stop_editing, id}, socket) do
    editing = socket.assigns.editing -- [String.to_integer(id)]
    {:noreply, push_patch(socket, to: Routes.todo_index_path(socket, :index, editing: editing))}
  end

  defp list_todos do
    Todos.list_todos()
  end
end
