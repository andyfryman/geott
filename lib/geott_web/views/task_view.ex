defmodule GeottWeb.TaskView do
  use GeottWeb, :view
  alias GeottWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      status: task.status,
      driver_id: task.driver_id,
      pickup: Enum.reverse(Tuple.to_list(task.pickup_point.coordinates)),
      delivery: Enum.reverse(Tuple.to_list(task.delivery_point.coordinates))}
  end
end
