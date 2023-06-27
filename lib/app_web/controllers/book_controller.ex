defmodule AppWeb.BookController do
  use AppWeb, :controller

  alias App.Stores
  alias App.Stores.Book

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    books = Stores.list_books()
    render(conn, :index, books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Stores.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Stores.get_book!(id)
    render(conn, :show, book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Stores.get_book!(id)

    with {:ok, %Book{} = book} <- Stores.update_book(book, book_params) do
      render(conn, :show, book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Stores.get_book!(id)

    with {:ok, %Book{}} <- Stores.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
