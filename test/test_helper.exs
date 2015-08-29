ExUnit.start

#setup db for test
Trs.Couchdb.Http.request(:delete, "trs-db")
Trs.Couchdb.Http.request(:put, "trs-db")
