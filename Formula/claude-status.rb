class ClaudeStatus < Formula
  desc "Real-time token usage and cost monitoring for Claude Code"
  homepage "https://github.com/oscarangulo/claude-status"
  url "https://github.com/oscarangulo/claude-status/archive/refs/tags/v0.4.8.tar.gz"
  sha256 "1c72e04c52f6e63df56d7bc5eca5e3c30c2d854b9ce1f66e84313be23e823822"
  license "MIT"
  head "https://github.com/oscarangulo/claude-status.git", branch: "main"

  depends_on "go" => :build
  depends_on "jq"

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/claude-status/"
  end

  def caveats
    <<~EOS
      To configure Claude Code hooks, run:
        claude-status install

      Then restart Claude Code.

      To update hooks after upgrading:
        claude-status update
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-status --version")
  end
end
