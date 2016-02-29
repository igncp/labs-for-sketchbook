package main

import (
	"fmt"
	"github.com/prometheus/client_golang/prometheus"
)

func main() {
	foo := prometheus.NewGauge(prometheus.GaugeOpts{
		Namespace: "bar_namespace",
		Subsystem: "baz_subsystem",
		Name:      "foo_label_name",
		Help:      "The foo help",
	})

	prometheus.MustRegister(foo)
	foo.Inc()

	fmt.Println("gauge foo desc", foo.Desc().String())
}
