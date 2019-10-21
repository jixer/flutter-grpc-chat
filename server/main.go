package main

import (
	"os"

	"golang.org/x/net/context"
)

const (
	host = ":50001"
)

func main() {
	ctx := SignalContext(context.Background())
	err := Server(host).Run(ctx)
	if err != nil {
		ServerLogf("Fatal error occured: %s", err.Error())
		ServerLogf("Terminating...")
		os.Exit(1)
	}
}
