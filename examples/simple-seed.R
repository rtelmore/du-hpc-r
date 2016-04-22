library(pbdMPI, quiet = TRUE)
init()

.comm.size <- comm.size()
.comm.rank <- comm.rank()
.hostname <- Sys.info()["nodename"]
comm.set.seed(123456, diff = TRUE)
x.spmd <- sample(1:10, size = 1)
msg <- sprintf("Random number: %d on %d and %s.\n", x.spmd, .comm.rank, .hostname)
comm.cat(msg, all.rank = TRUE, quiet = TRUE)
gt <- gather(x.spmd)  ## allgather
comm.print(gt)
sm <- reduce(x.spmd) ## allreduce
comm.print(sm)

finalize()
