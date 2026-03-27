class ClaudeStatus < Formula
  desc "Real-time token usage and cost monitoring for Claude Code"
  homepage "https://github.com/oscarangulo/claude-status"
  url "https://github.com/oscarangulo/claude-status/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "0aae781cd671cc277bb064fa32317d671d79b1ec7c2b03c0c8008d857dca7e25"
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
