defmodule GeottWeb.TaskController do
  use GeottWeb, :controller

  alias Geott.Tasks
  alias Geott.Tasks.Task

  action_fallback GeottWeb.FallbackController

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def search(conn, %{"params" => params}) do
    with {:ok, tasks} <- Tasks.search_tasks(params) do
      render(conn, "index.json", tasks: tasks)
    end
  end
end
