defmodule Word do
  # @choose %__MODULE__{}
  @word ~r{(\\n|[^\w'])+}
  # @char ~r{(\\n | [^\w'])}
  @char ~r{\w}
  @line "\n"

  # defstruct [
  #   words: "~r{(\\n | [^\w'])+}",
  #   char:  "~r{(\\n | [^\w]}",
  #   lines: "\n",
  # ]

  def count() do
    a = "Enter filename: "
        |> IO.gets
        |> String.trim

    b = "how do we count it? [word|char|line]: "
        |> IO.gets
        |> String.trim
        |> String.downcase

    _solve(a, b)
      |> Enum.filter(&(&1 !=""))
      |> Enum.count
      |> IO.puts

    "Count again? [ Yes | No ]:"
    |> IO.gets
    |> String.trim
    |> String.downcase
    |> case do
      "yes" -> count()
      "y" -> count()
      "no" -> Process.exit(self(), :normal)
      "n" -> Process.exit(self(), :normal)
      _ ->
        IO.puts "wrong params"
        count()
    end

  end

  defp _solve(_filename, "exit"), do: Process.exit(self(), :normal)

  defp _solve(filename, "word") do
    # me thinks that this won't work,
    # choose = %__MODULE__{}

    filename
    |> File.read!
    # |> String.split(choose.words)
    |> String.split(@word)
  end

  defp _solve(filename, "char") do
    filename
    |> File.read!
    |> String.split("\n")
    |> Enum.join("")
    |> String.codepoints
    |> Enum.filter(&Regex.match?(@char, &1))
  end
  # "123\ntry\nsaw" |> String.split("\n") |> Enum.join("") |> String.codepoints |> Enum.filter(fn x -> Regex.match?(~r{[^\d]}, x) end)

  defp _solve(filename, "line") do
    filename |> File.read! |> String.split(@line)
  end

end
