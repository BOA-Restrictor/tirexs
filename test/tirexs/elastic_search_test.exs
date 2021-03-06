defmodule Tirexs.ElasticSearchTest do
  use ExUnit.Case

  import Tirexs.ElasticSearch


  @uri_environment Application.get_env(:tirexs, :uri)


  test "`uri` environment variable" do
    assert @uri_environment == %URI{ scheme: "http", userinfo: nil, host: "127.0.0.1", port: 9200 }
  end

  test "config/0" do
    actual = config()
    assert actual == @uri_environment
  end

  test "make_url/0 by default" do
    actual = make_url("articles", config())
    assert actual == "http://127.0.0.1:9200/articles"
  end

  test "make_url/1 by key, value" do
    actual = make_url("articles", config(scheme: "http", userinfo: "user:pass", host: "localhost", port: 9201))
    assert actual == "http://user:pass@localhost:9201/articles"
  end

  test "make_url/1 by key, value w/ out userinfo" do
    actual = make_url("articles", config(scheme: "https", host: "0.0.0.0", port: 9201))
    assert actual == "https://0.0.0.0:9201/articles"
  end

  test "make_url/1 by string" do
    actual = make_url("articles", config("https://user:pass@example.com:9201"))
    assert actual == "https://user:pass@example.com:9201/articles"
  end
end
