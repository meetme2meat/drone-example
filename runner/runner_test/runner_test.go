package runner_test


import (
    "drone-ci/runner"
    . "github.com/onsi/ginkgo"
    . "github.com/onsi/gomega"
    "testing"
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
})
