package runner_test

import (
	"drone-ci/runner"
	"testing"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

func TestRunner(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Runner Suite")
}

var _ = Describe("Runner", func() {
	Context("Test Run", func() {
		It("should return `running`", func() {
			Ω(runner.Run()).Should(Equal("running ..."))
		})
	})

	Context("Test Stop", func() {
		It("should return `stopped!`", func() {
			Ω(runner.Stop()).Should(Equal("stopped!"))
		})
	})
})
