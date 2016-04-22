library(pbdDMAT, quiet = TRUE)
init.grid()

### Generate balanced fake data.
comm.set.seed(1234, diff = TRUE)
N <- 100                
p <- 2

dx <- ddmatrix(rnorm(N * p), ncol = p)
dbeta <- ddmatrix(1:p, ncol = 1)
depsilon <- ddmatrix(rnorm(N), ncol = 1)
dy <- dx %*% dbeta + depsilon 

dols <- solve(t(dx) %*% dx) %*% t(dx) %*% dy

ols <- as.matrix(dols, proc.dest = 0)

comm.cat("Straight matrix multiplation:\n", quiet = TRUE)
comm.print(ols, quiet = TRUE)

## alternatively
dres <- lm.fit(dx, dy)
res <- as.matrix(dres$coef, proc.dest = 0)
comm.cat("\nUsing lm.fit:\n", quiet = TRUE)
comm.print(res, quiet = TRUE)

## Undistribute and computed
x <- as.matrix(dx, proc.dest = 0)
y <- as.matrix(dy, proc.dest = 0)
if(comm.rank() == 0){
  serial.coef <- lm(y ~ x - 1)$coef
}
comm.cat("\nSerial fit:\n", quiet = TRUE)
comm.print(serial.coef, quiet = TRUE)

finalize()
