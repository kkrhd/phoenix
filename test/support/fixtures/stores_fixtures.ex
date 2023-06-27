defmodule App.StoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Stores` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> App.Stores.create_book()

    book
  end
end
