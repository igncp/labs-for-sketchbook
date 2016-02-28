package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/prometheus/prometheus/util/cli"
)

func SayHelloCmd(t cli.Term, args ...string) int {

	if len(args) > 0 {
		fmt.Println("Hello", strings.Join(args[:], " "), "!")
	} else {
		fmt.Println("Hello")
	}

	return 0
}

func main() {
	app := cli.NewApp("foo-cli")

	app.Register("say-hello", &cli.Command{
		Desc: "Says hello. It accepts arguments.",
		Run:  SayHelloCmd,
	})

	t := cli.BasicTerm(os.Stdout, os.Stderr)
	os.Exit(app.Run(t, os.Args[1:]...))
}
