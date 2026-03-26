class ClaudeStatus < Formula
  desc "Real-time token usage and cost monitoring for Claude Code"
  homepage "https://github.com/oscarangulo/claude-status"
  url "https://github.com/oscarangulo/claude-status/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b4b216eff8f1aa122964496938d929f268922909dcb2ba64d713405bf6626d74"
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
