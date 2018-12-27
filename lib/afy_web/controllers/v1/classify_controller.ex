defmodule AfyWeb.V1.ClassifyController do
  use AfyWeb, :controller

  action_fallback AfyWeb.FallbackController

  def classify(conn, %{"tx_id" => tx_id, "interaction_id" => int_id, "valued_answer" => answer}) do
    with ce_res <- HS.answer_valued_question(tx_id, int_id, answer),
         res <- response_format(ce_res) do
      conn
      |> put_status(:ok)
      |> json(res)
    end
  end
  def classify(conn, %{"tx_id" => tx_id, "interaction_id" => int_id, "answer" => answer}) do
    res = HS.answer_question(tx_id, int_id, answer)
      |> response_format()

    conn
    |> put_status(:ok)
    |> json(res)
  end
  def classify(conn, %{"description" => desc}) do
    res = HS.describe_product(desc)
      |> response_format()

    conn
    |> put_status(:ok)
    |> json(res)
  end

  defp response_format(res) do
    case res do
      {status, tx_id, ce_res} ->
        Map.new()
        |> Map.put("response", ce_res)
        |> Map.put("tx_id", tx_id)
        |> Map.put("status", Atom.to_string(status))
      {status, tx_id, interaction_id, ce_res} ->
        Map.new()
        |> Map.put("response", ce_res)
        |> Map.put("tx_id", tx_id)
        |> Map.put("status", Atom.to_string(status))
        |> Map.put("interaction_id", interaction_id)
    end
  end
end
