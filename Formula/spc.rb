class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.2.tar.gz"
  sha256 "f9d7aa072f417c67e59912542d5bf5054d48b2d8052dbc6f6b144adc86470727"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "4bdd18d1938366f2b3a7828009a9b6fba988b5ca363197aae2d8952abbf00ae3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7352dae0dddfaa4f3e4c0398ebee39dc8bf939341b4af467557e3e65742f82fe"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
