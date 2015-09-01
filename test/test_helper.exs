ExUnit.start

#setup db for test
Trs.Couchdb.Http.request(:delete, "trs-db")
Trs.Couchdb.Http.request(:put, "trs-db")
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(Trs.Repo)
