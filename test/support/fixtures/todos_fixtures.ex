defmodule Recovery.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recovery.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Recovery.Todos.create_todo()

    todo
  end
end
