defmodule Geott.TasksTest do
  use Geott.DataCase

  alias Geott.Tasks

  describe "tasks" do
    alias Geott.Tasks.Task

    @valid_attrs %{status: :new, pickup: [30, 30], delivery: [60, 60]}
    @update_attrs %{status: :assigned}
    @invalid_attrs %{status: "invalid"}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert length(Tasks.list_tasks()) == length([task])
    end

    test "get_task!/1 returns the task with given id" do
      expected = task_fixture()
      actual = Tasks.get_task!(expected.id)
      assert actual.id == expected.id
      assert actual.status == expected.status
      assert actual.driver_id == expected.driver_id
      assert actual.pickup_point == expected.pickup_point
      assert actual.delivery_point == expected.delivery_point
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.status == :new
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)
      assert task.status == :assigned
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task.id == Tasks.get_task!(task.id).id
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
