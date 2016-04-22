library(pbdMPI, quiet = TRUE)
init()
.comm.size <- comm.size()
.comm.rank <- comm.rank()
.hostname <- Sys.info()["nodename"]

msg <- sprintf("I am %d of %d on %s.\n", .comm.rank, .comm.size, .hostname)
comm.cat(msg, all.rank = TRUE, quiet = TRUE)

finalize()
