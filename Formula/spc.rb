class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.3.tar.gz"
  sha256 "670b25a5a213a467b10b3fff9cb541e66f897155e8c655c2f0dbbf43f498c5d8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, big_sur:      "f154d405db6931971a3be424a6ce14b75a941f3b42674fa6dd2a61d6daa6de2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69c987b3b5983a9bdb558ea7d5b755438277c886f58209fa445a5200d2e0fce7"
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
